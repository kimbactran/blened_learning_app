import 'dart:convert';

import 'package:blended_learning_appmb/utils/http/api.dart';
import 'package:http/http.dart' as http;

class LHttpHelper {
  static const String _baseUrl = LApi.baseUrl;

  // Helper method to make a GET request
  static Future<http.Response> get(String endpoint, String? token) async {
    var header = {
      'Content-Type': 'application/json',
    };
    if (token!.isNotEmpty) {
      header['Authorization'] = 'Bearer ${token}';
    }
    final response =
        await http.get(Uri.parse('$_baseUrl$endpoint'), headers: header);
    return response;
  }

  // Helper method to make a POST request
  static Future<http.Response> post(
      String endpoint, dynamic data, String? token) async {
    var header = {
      'Content-Type': 'application/json',
    };
    if (token!.isNotEmpty) {
      header['Authorization'] = 'Bearer ${token}';
    }
    final response = await http.post(Uri.parse('$_baseUrl$endpoint'),
        headers: header, body: json.encode(data));
    return response;
  }

  // Helper method to make a PUT request
  static Future<http.Response> put(
      String endpoint, dynamic data, String? token) async {
    var header = {
      'Content-Type': 'application/json',
    };
    if (token!.isNotEmpty) {
      header['Authorization'] = 'Bearer ${token}';
    }
    final response = await http.put(Uri.parse('$_baseUrl$endpoint'),
        headers: header, body: json.encode(data));
    return response;
  }

  static Future<http.Response> delete(String endpoint, String? token) async {
    var header = {
      'Content-Type': 'application/json',
    };
    if (token!.isNotEmpty) {
      header['Authorization'] = 'Bearer ${token}';
    }
    final response =
        await http.delete(Uri.parse('$_baseUrl$endpoint'), headers: header);
    return response;
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data ${response.statusCode}');
    }
  }
}
