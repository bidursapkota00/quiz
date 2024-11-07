import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz/core/constants.dart';

class HomeRepository {
  Future<List<String>> getSubjects(String token) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString('token');

    // if (token == null) {
    //   throw Exception('No token found');
    // }

    final response = await http.get(
      Uri.parse(baseUrl + subjectsEndpoint),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 401) {
      throw Exception('Token expired');
    }

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    }

    return [];
  }
}
