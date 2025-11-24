import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  const baseUrl = "http://localhost:8080";
  const loginUrl = "$baseUrl/auth/v1/login";
  const getDonationsURL= "$baseUrl/donations/v1";

  test("Login e buscar por ID usando token", () async {
    final loginResponse = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": "julianocolerecmoreira@gmail.com",
        "password": "senha"
      }),
    );

    expect(loginResponse.statusCode, 200);

    final loginData = jsonDecode(loginResponse.body);
    final token = loginData["token"];
    expect(token, isNotNull);

    print("TOKEN = $token");

    final getResponse = await http.get(
      Uri.parse("$getDonationsURL"),

      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );

    expect(getResponse.statusCode, 200);

    final list = jsonDecode(getResponse.body);

    print("LISTA COMPLETA = $list");

    expect(list, isA<List>());
    expect(list.length, greaterThan(0));
  });
}
