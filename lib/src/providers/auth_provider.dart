import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  late User _user;
  String baseUrl = 'https://api.ledinhcuong.com/v1';
  bool _authenticated = false;

  bool get isAuthenticated => _authenticated;

  User get user => _user;

  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        _saveUserData(responseData);
        _authenticated = true;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email_username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (kDebugMode) {
          print("Login: $responseData");
        }
        _saveUserData(responseData);
        _authenticated = true;
        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error: $error");
      }
      rethrow;
    }
  }

  Future<void> getUserData() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token') ?? '';

      final response = await Dio().get(
        '$baseUrl/user',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        _user = User.fromJson(responseData);
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  void _saveUserData(Map<String, dynamic> responseData) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'auth-token', responseData['data']['authentication']['access_token']);
    preferences.setString('auth-user_id', responseData['data']['user']['id']);

    _user = User.fromJson(responseData['data']['user']);
    if (kDebugMode) {
      var data = responseData['data']['user'];
      print("Data: $data");
      var avatar = _user.avatarUrl;
      print("User: $avatar");
    }
  }

  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('auth-access_token');
    preferences.remove('auth-user_id');
    _authenticated = false;
    notifyListeners();
  }
}
