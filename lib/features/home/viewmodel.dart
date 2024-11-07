import 'package:flutter/material.dart';
import 'package:quiz/features/auth/viewmodel.dart';
import 'repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();
  List<String> _subjects = [];
  bool _isLoading = true;
  bool _authError = false;

  List<String> get subjects => _subjects;
  bool get isLoading => _isLoading;
  bool get authError => _authError;

  Future<void> loadSubjects(
      String token, String refresh, AuthViewModel authProvider) async {
    try {
      _subjects = await _homeRepository.getSubjects(token);
    } catch (error) {
      try {
        await authProvider.refreshToken(refresh);
        _subjects = await _homeRepository.getSubjects(authProvider.token ?? '');
      } catch (e) {
        _authError = true;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
