// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/timetable/models/group_model.dart';
import 'package:rikedu/src/utils/constants/keys_storage_constants.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';
import 'package:rikedu/src/utils/widgets/snackbar_widget.dart';

class AuthController extends GetxController {
  final authProvider = AuthProvider();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final localStorage = GetStorage();

  final Rx<User> _user = User(
    id: '',
    username: '',
    email: '',
    fullName: '',
    avatarUrl: '',
    gender: '',
    dateOfBirth: DateTime.now(),
    phone: '',
    address: '',
    department: '',
  ).obs;

  final RxBool _isLoading = false.obs;
  final RxBool _isObscure = true.obs;
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;
  final _formKey = GlobalKey<FormState>();

  bool get isLoading => _isLoading.value;
  bool get isObscure => _isObscure.value;
  User get user => _user.value;
  String get email => _email.value;
  String get password => _password.value;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
  }

  void toggleObscure() {
    _isObscure.value = !_isObscure.value;
  }

  void setIsLoading() {
    _isLoading.value = !_isLoading.value;
  }

  void setEmail(String? value) {
    _email.value = value!.trim();
    print(_email.value);
  }

  void setPassword(String? value) {
    _password.value = value!.trim();
    print(_password.value);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;
      final response = await authProvider.login(_email.value, _password.value);
      // print(response.body);
      _isLoading.value = false;
      if (response.body['success']) {
        print(response.body['data']['user']);
        _user.value = User.fromJson(response.body['data']['user']);
        setUser(_user.value);
        setData(response.body['data']);
        Get.offAllNamed(Routes.HOME);
        print('Logged in successfully');
      } else {
        SnackbarWidget.showSnackbar('Invalid email or password');
      }
    } else {
      print('Please enter valid credentials');
    }
  }

  void setData(dynamic data) {
    String userToken = data['authentication']['access_token'][0];
    localStorage.write(KeysStorageConst.USER_TOKEN, userToken);
    String userRole = data['authorization']['role'][0];
    localStorage.write(KeysStorageConst.USER_ROLE, userRole);

    if (userRole == RolesConst.PARENT) {
      User student = User.fromJson(data['student'][0]);
      localStorage.write(
          KeysStorageConst.STUDENT_DATA, jsonEncode(student.toJson()));
    }
    if (userRole == RolesConst.STUDENT) {
      User parent = User.fromJson(data['parent']);
      Group group = Group.fromJson(data['group'][0]);
      localStorage.write(
          KeysStorageConst.PARENT_DATA, jsonEncode(parent.toJson()));
      localStorage.write(
          KeysStorageConst.GROUP_DATA, jsonEncode(group.toJson()));
    }
  }

  void setUser(User user) {
    localStorage.write(KeysStorageConst.USER_DATA, jsonEncode(user.toJson()));
  }

  Future<User?> getUser() async {
    try {
      final userJson = await localStorage.read(KeysStorageConst.USER_DATA);
      return userJson ? User.fromJson(userJson) : null;
    } catch (e) {
      rethrow;
    }
  }
}
