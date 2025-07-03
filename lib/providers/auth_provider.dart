// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_app/services/auth_service.dart'; // Sesuaikan package name

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = true;
  int _selectedIndex = 0; // Untuk Bottom Navigation Bar

  AuthProvider() {
    _authService.user.listen((user) {
      _user = user;
      _isLoading = false;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await _authService.signInWithEmailAndPassword(email, password);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tambahkan parameter 'name' di sini
  Future<void> signUpWithEmailAndPassword(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await _authService.signUpWithEmailAndPassword(email, password, name); // Meneruskan nama
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signOut();
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}