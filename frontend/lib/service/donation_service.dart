import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/constants/api.dart';
import 'package:frontend/model/donation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationService {
  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<Map<String, String>> _headers() async {
    final token = await _getToken();

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Donation> createDonation(Donation donation) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/donations/v1");

    final response = await http.post(
      url,
      headers: await _headers(),
      body: jsonEncode(donation.toJson()),
    );

    if (response.statusCode == 200) {
      return Donation.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao criar doação: ${response.statusCode}");
    }
  }

  static Future<Donation> getDonationById(int id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/donations/v1/$id");

    final response = await http.get(
      url,
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      return Donation.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao buscar doação $id");
    }
  }

  static Future<List<Donation>> listAllDonations() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/donations/v1");

    final response = await http.get(
      url,
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      return list.map((e) => Donation.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao listar doações");
    }
  }

  static Future<List<Donation>> listDonationsByDonor(int donorId) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/donations/v1/donor/$donorId");

    final response = await http.get(
      url,
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = json.decode(response.body);
      return list.map((e) => Donation.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao listar doações do doador $donorId");
    }
  }

  static Future<bool> deleteDonation(int id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/donations/v1/$id");

    final response = await http.delete(
      url,
      headers: await _headers(),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception("Erro ao deletar doação $id");
    }
  }
}
