import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  late User _user;
  bool _authenticated = false;
  bool get isAuthenticated => _authenticated;
  User get user => _user;

  Future<void> post(String emailUsername, String password) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'email_username': emailUsername,
          'password': password,
        },
      );
      if (kDebugMode) {
        print('User: ${response.data}');
      }
      _saveUserData(response.data);
      _authenticated = true;
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
      rethrow;
    }
  }

  Future<void> login(String emailUsername, String password) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'email_username': emailUsername,
          'password': password,
        },
      );
      if (kDebugMode) {
        print('User: ${response.data}');
      }
      _saveUserData(response.data);
      _authenticated = true;
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
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
