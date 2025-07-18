import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyProvider with ChangeNotifier {
  String _currentCurrency = 'EUR';
  
  String get currentCurrency => _currentCurrency;
  
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
    return '$currencySymbol${amount.toStringAsFixed(2)}';
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
    
    notifyListeners();
  }
  
  Future<void> resetToLanguageDefault(String languageCode) async {
    final defaultCurrency = _languageDefaults[languageCode] ?? 'EUR';
    await setCurrency(defaultCurrency);
  }
}
