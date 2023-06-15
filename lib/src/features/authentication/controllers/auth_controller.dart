import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/widgets/snackbar_widget.dart';

class AuthController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Rx<User> _user = User.defaultUser().obs;

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
  }

  void setPassword(String? value) {
    _password.value = value!.trim();
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
      await authProvider.login(_email.value, _password.value);
      _isLoading.value = false;
      if (authProvider.isAuthenticated) {
        Get.offAllNamed(Routes.HOME);
        SnackbarWidget.showSnackbarSuccess(authProvider.responseMessage);
      } else {
        SnackbarWidget.showSnackbar(authProvider.responseMessage);
      }
    } else {
      SnackbarWidget.showSnackbar('Please enter valid credentials');
    }
  }
}
