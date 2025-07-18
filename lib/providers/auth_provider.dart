import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _currentUser;
  
  bool get isAuthenticated => _isAuthenticated;
  String? get currentUser => _currentUser;

  Future<void> initAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _currentUser = prefs.getString('currentUser');
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    // Demo login - in real app, this would call an API
    if (username == 'admin' && password == 'admin123') {
      _isAuthenticated = true;
      _currentUser = username;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('currentUser', username);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _currentUser = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
    await prefs.remove('currentUser');
    
    notifyListeners();
  }
}
