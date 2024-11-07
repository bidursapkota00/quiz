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
      String refresh = data['refresh'];

      // Save token to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('token', token),
        prefs.setString('refresh', refresh),
      ]);

      return token;
    }

    return null;
  }

  Future<Map<String, String?>> refresh(String refresh) async {
    final response = await http.post(
      Uri.parse(baseUrl + refreshEndpoint),
      headers: {'Authorization': 'Bearer $refresh'},
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      String token = data['access'];
      String refresh = data['refresh'];

      // Save token to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await Future.wait([
        prefs.setString('token', token),
        prefs.setString('refresh', refresh),
      ]);

      return {
        'token': token,
        'refresh': refresh,
      };
    }
    return {
      'token': null,
      'refresh': null,
    };
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
    await Future.wait([
      prefs.remove('token'),
      prefs.remove('refresh'),
    ]);
  }

  Future<Map<String, String?>> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve both 'token' and 'refresh'
    String? token = prefs.getString('token');
    String? refresh = prefs.getString('refresh');

    return {
      'token': token,
      'refresh': refresh,
    };
  }
}
