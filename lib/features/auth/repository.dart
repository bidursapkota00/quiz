import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz/core/constants.dart';

class AuthRepository {
  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl + loginEndpoint),
      body: jsonEncode({"username": username, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['access'];

      // Save token to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      return token;
    }

    return null;
  }

  Future<bool> register(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse(baseUrl + registerEndpoint),
      body: jsonEncode(
          {"username": username, "password": password, "email": email}),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 201;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
