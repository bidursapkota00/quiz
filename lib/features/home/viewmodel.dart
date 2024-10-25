import 'package:flutter/material.dart';
import 'repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepository();
  List<String> _subjects = [];
  bool _isLoading = true;
  bool _authError = false;

  List<String> get subjects => _subjects;
  bool get isLoading => _isLoading;
  bool get authError => _authError;

  Future<void> loadSubjects() async {
    try {
      _subjects = await _homeRepository.getSubjects();
    } catch (e) {
      _authError = true; // Set auth error flag if an exception occurs
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
