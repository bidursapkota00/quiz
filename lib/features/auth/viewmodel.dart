import 'package:flutter/material.dart';
import 'repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  String? _token;
  bool _isLoading = false;

  String? get token => _token;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    setLoading(true);
    _token = await _authRepository.login(username, password);
    setLoading(false);
    notifyListeners();
    return _token != null;
  }

  Future<bool> register(String username, String password, String email) async {
    setLoading(true);
    bool success = await _authRepository.register(username, password, email);
    setLoading(false);
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _token = null;
    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await _authRepository.getToken();
    notifyListeners();
  }
}
