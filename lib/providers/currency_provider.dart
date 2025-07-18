import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyProvider with ChangeNotifier {
  String _currentCurrency = 'EUR';
  String _baseCurrency = 'EUR'; // Base currency for all prices
  
  String get currentCurrency => _currentCurrency;
  String get baseCurrency => _baseCurrency;
  
  // Currency options with symbols
  final Map<String, String> _currencies = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'TRY': '₺',
    'JPY': '¥',
    'CHF': 'CHF',
    'CAD': 'C\$',
    'AUD': 'A\$',
  };
  
  // Exchange rates (EUR as base currency)
  Map<String, double> _exchangeRates = {
    'USD': 1.09,    // 1 EUR = 1.09 USD
    'EUR': 1.0,     // Base currency
    'GBP': 0.85,    // 1 EUR = 0.85 GBP
    'TRY': 35.50,   // 1 EUR = 35.50 TRY
    'JPY': 163.25,  // 1 EUR = 163.25 JPY
    'CHF': 0.93,    // 1 EUR = 0.93 CHF
    'CAD': 1.48,    // 1 EUR = 1.48 CAD
    'AUD': 1.64,    // 1 EUR = 1.64 AUD
  };
  
  DateTime? _lastUpdated;
  bool _isLoading = false;
  
  DateTime? get lastUpdated => _lastUpdated;
  bool get isLoading => _isLoading;
  
  // Free API: ExchangeRate-API
  static const String _apiUrl = 'https://api.exchangerate-api.com/v4/latest/EUR';
  
  // Fetch real-time exchange rates
  Future<void> fetchExchangeRates() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['rates'] as Map<String, dynamic>;
        
        // Update exchange rates
        _exchangeRates = {
          'EUR': 1.0, // Base currency
          'USD': (rates['USD'] ?? 1.09).toDouble(),
          'GBP': (rates['GBP'] ?? 0.85).toDouble(),
          'TRY': (rates['TRY'] ?? 35.50).toDouble(),
          'JPY': (rates['JPY'] ?? 163.25).toDouble(),
          'CHF': (rates['CHF'] ?? 0.93).toDouble(),
          'CAD': (rates['CAD'] ?? 1.48).toDouble(),
          'AUD': (rates['AUD'] ?? 1.64).toDouble(),
        };
        
        _lastUpdated = DateTime.now();
        
        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('exchange_rates', json.encode(_exchangeRates));
        await prefs.setString('last_updated', _lastUpdated!.toIso8601String());
        
        print('Exchange rates updated successfully');
      } else {
        print('Failed to fetch exchange rates: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
      // Load from cache if available
      await _loadCachedRates();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Load cached exchange rates
  Future<void> _loadCachedRates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedRates = prefs.getString('exchange_rates');
      final cachedDate = prefs.getString('last_updated');
      
      if (cachedRates != null) {
        final rates = json.decode(cachedRates) as Map<String, dynamic>;
        _exchangeRates = rates.map((key, value) => MapEntry(key, value.toDouble()));
      }
      
      if (cachedDate != null) {
        _lastUpdated = DateTime.parse(cachedDate);
      }
    } catch (e) {
      print('Error loading cached rates: $e');
    }
  }
  
  // Check if rates need to be updated (older than 1 hour)
  bool _needsUpdate() {
    if (_lastUpdated == null) return true;
    return DateTime.now().difference(_lastUpdated!).inHours >= 1;
  }
  
  // Auto-update rates if needed
  Future<void> updateRatesIfNeeded() async {
    if (_needsUpdate()) {
      await fetchExchangeRates();
    }
  }
  
  Map<String, String> get currencies => _currencies;
  
  String get currencySymbol => _currencies[_currentCurrency] ?? '€';
  
  // Default currency based on language
  final Map<String, String> _languageDefaults = {
    'en': 'USD',
    'tr': 'TRY', 
    'es': 'EUR',
    'fr': 'EUR',
    'it': 'EUR',
    'de': 'EUR',
  };
  
  String formatPrice(double amount) {
    final convertedAmount = _convertCurrency(amount, _baseCurrency, _currentCurrency);
    
    // Japanese Yen doesn't use decimal places
    if (_currentCurrency == 'JPY') {
      return '$currencySymbol${convertedAmount.round()}';
    }
    
    return '$currencySymbol${convertedAmount.toStringAsFixed(2)}';
  }
  
  // Convert amount from one currency to another
  double _convertCurrency(double amount, String fromCurrency, String toCurrency) {
    if (fromCurrency == toCurrency) return amount;
    
    final fromRate = _exchangeRates[fromCurrency] ?? 1.0;
    final toRate = _exchangeRates[toCurrency] ?? 1.0;
    
    // Convert to EUR first (base currency), then to target currency
    final eurAmount = amount / fromRate;
    return eurAmount * toRate;
  }
  
  // Get conversion rate for display purposes
  double getConversionRate(String fromCurrency, String toCurrency) {
    return _convertCurrency(1.0, fromCurrency, toCurrency);
  }
  
  // Format price with currency conversion info
  String formatPriceWithInfo(double amount, {bool showConversion = false}) {
    final formattedPrice = formatPrice(amount);
    
    if (showConversion && _currentCurrency != _baseCurrency) {
      final rate = getConversionRate(_baseCurrency, _currentCurrency);
      return '$formattedPrice (Rate: 1 $_baseCurrency = ${rate.toStringAsFixed(4)} $_currentCurrency)';
    }
    
    return formattedPrice;
  }
  
  String formatPriceString(String price) {
    // Remove existing currency symbols and extract number
    String cleanPrice = price.replaceAll(RegExp(r'[^\d.,]'), '');
    if (cleanPrice.isEmpty) return formatPrice(0);
    
    try {
      double amount = double.parse(cleanPrice.replaceAll(',', '.'));
      return formatPrice(amount);
    } catch (e) {
      return formatPrice(0);
    }
  }
  
  Future<void> setCurrency(String currency) async {
    if (_currencies.containsKey(currency)) {
      _currentCurrency = currency;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_currency', currency);
    }
  }
  
  Future<void> initializeCurrency(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCurrency = prefs.getString('selected_currency');
    
    if (savedCurrency != null && _currencies.containsKey(savedCurrency)) {
      _currentCurrency = savedCurrency;
    } else {
      // Set default based on language
      _currentCurrency = _languageDefaults[languageCode] ?? 'EUR';
      await prefs.setString('selected_currency', _currentCurrency);
    }
    
    // Load cached exchange rates first
    await _loadCachedRates();
    
    // Update rates if needed (in background)
    updateRatesIfNeeded();
    
    notifyListeners();
  }
  
  Future<void> resetToLanguageDefault(String languageCode) async {
    final defaultCurrency = _languageDefaults[languageCode] ?? 'EUR';
    await setCurrency(defaultCurrency);
  }
}
