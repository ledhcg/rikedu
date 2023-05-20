import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/timetable/models/group_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();

  bool _authenticated = false;
  bool _responseStatus = false;
  String _responseMessage = '';
  bool get isAuthenticated => _authenticated;
  bool get responseStatus => _responseStatus;
  String get responseMessage => _responseMessage;

  Future<void> init() async {
    checkIsAuthenticated();
  }

  void checkIsAuthenticated() {
    _authenticated = _storageService.hasData(StorageConst.USER_TOKEN);
  }

  Future<void> login(String emailUsername, String password) async {
    try {
      final response = await _apiService.post(ApiConst.LOGIN_ENDPOINT, {
        'email_username': emailUsername,
        'password': password,
      });

      if (response.body['success']) {
        _authenticated = true;
        setUser(User.fromJson(response.body['data']['user']));
        setData(response.body['data']);
        responseSuccess(response.body['message']);
        notifyListeners();
      } else {
        _authenticated = false;
        responseFail(response.body['message']);
        notifyListeners();
      }
    } catch (e) {
      responseFail(e.toString());
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout(String id) async {
    try {
      _storageService.clearData();
      _authenticated = false;
      _apiService.post(ApiConst.LOGOUT_ENDPOINT, {'id': id});
    } catch (e) {
      rethrow;
    }
  }

  void setData(Map<String, dynamic> data) {
    String userToken = data['authentication']['access_token'][0];
    _storageService.writeData(StorageConst.USER_TOKEN, userToken);
    String userRole = data['authorization']['role'][0];
    _storageService.writeData(StorageConst.USER_ROLE, userRole);

    if (userRole == RolesConst.PARENT) {
      // print(data['student'][0]);
      User student = User.fromJson(data['student'][0]);
      _storageService.writeData(
          StorageConst.STUDENT_DATA, jsonEncode(student.toJson()));
    }
    if (userRole == RolesConst.STUDENT) {
      print(data['parent'][0]);
      User parent = User.fromJson(data['parent']);
      Group group = Group.fromJson(data['group'][0]);
      _storageService.writeData(
          StorageConst.PARENT_DATA, jsonEncode(parent.toJson()));
      _storageService.writeData(
          StorageConst.GROUP_DATA, jsonEncode(group.toJson()));
    }
  }

  void setUser(User user) {
    _storageService.writeData(
        StorageConst.USER_DATA, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    try {
      final userJson = await _storageService.readData(StorageConst.USER_DATA);
      return userJson ? User.fromJson(jsonDecode(userJson)) : null;
    } catch (e) {
      rethrow;
    }
  }

  void responseSuccess(String message) {
    _responseStatus = true;
    _responseMessage = message;
  }

  void responseFail(String message) {
    _responseStatus = false;
    _responseMessage = message;
  }
}
