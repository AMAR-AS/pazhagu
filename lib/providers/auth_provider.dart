// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _userId;
  String? _token;
  bool _isAuthenticated = false;

  String? get userId => _userId;
  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    try {
      // TODO: Call backend API to login
      _isAuthenticated = true;
      _userId = 'user_123';
      _token = 'jwt_token_here';
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> signup(String name, String username, String email, String phoneNumber, String password) async {
    try {
      // TODO: Call backend API to signup
      // For now, we'll just simulate a successful signup
      notifyListeners();
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      // TODO: Call backend API to verify OTP
      _isAuthenticated = true;
      _userId = 'user_123';
      _token = 'jwt_token_here';
      notifyListeners();
    } catch (e) {
      throw Exception('OTP verification failed: $e');
    }
  }

  void logout() {
    _userId = null;
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
