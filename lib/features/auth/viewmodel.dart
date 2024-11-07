import 'package:flutter/material.dart';
import 'repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  String? _token;
  String? _refresh;
  bool _isLoading = false;

  String? get token => _token;
  String? get refresh => _refresh;
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

  Future<bool> refreshToken(String refresh) async {
    Map<String, String?> tokens = await _authRepository.refresh(refresh);
    if (_token != null && _refresh != null) {
      _token = tokens['token'];
      _refresh = tokens['refresh'];
      notifyListeners();
      return true;
    }
    return false;
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
    Map<String, String?> tokens = await _authRepository.getToken();
    _token = tokens['token'];
    _refresh = tokens['refresh'];

    notifyListeners();
  }
}
