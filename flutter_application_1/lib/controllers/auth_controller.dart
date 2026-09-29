import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../services/api_service.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  final ApiService _api = ApiService();

  bool _isLoading = false;
  String _currentRole = 'coord';
  Map<String, dynamic>? _currentUser;

  bool get isLoading => _isLoading;
  String get currentRole => _currentRole;
  Map<String, dynamic>? get currentUser => _currentUser;
  bool get isAdmin => _currentRole == 'admin' || _currentRole == 'coord';

  void setRole(String role) {
    _currentRole = role;
    MockData().currentRole = role;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.login(email, password);
      _currentUser = response['user'];
      final role =
          _currentUser?['role'] ??
          (email.contains('admin') ? 'admin' : 'professor');
      _currentRole = role == 'admin' ? 'coord' : 'prof';
      MockData().currentRole = _currentRole;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (_) {
      _currentRole = (email.contains('admin') || _currentRole == 'coord')
          ? 'coord'
          : 'prof';
      MockData().currentRole = _currentRole;
      _isLoading = false;
      notifyListeners();
      return true;
    }
  }

  void logout() {
    _api.setToken(null);
    _currentUser = null;
    _currentRole = 'coord';
    notifyListeners();
  }
}
