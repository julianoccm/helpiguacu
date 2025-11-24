import 'dart:convert';

import 'package:frontend/constants/api.dart';
import 'package:frontend/model/auth_representation.dart';
import 'package:frontend/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  static Future<void> authenticate(AuthRepresentation auth) async {
    final baseUrl = ApiConfig.baseUrl;
    final url = Uri.parse("$baseUrl/auth/v1/login");

    final response = await http.post(
      url,
      body: jsonEncode(auth.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('user', jsonEncode(data['user']).toString());
    } else {
      throw Exception();
    }
  }

  static Future<bool> register(User user) async {
    final baseUrl = ApiConfig.baseUrl;
    final url = Uri.parse("$baseUrl/auth/v1/register");

    final response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }
}
