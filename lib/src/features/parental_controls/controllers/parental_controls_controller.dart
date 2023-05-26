import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/widgets/snackbar_widget.dart';

class ParentalControlsController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<User> _student = User.defaultUser().obs;
  User get student => _student.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final RxString _titleNoti = ''.obs;
  String get titleNoti => _titleNoti.value;
  set titleNoti(String? value) => _titleNoti.value = value!.trim();

  final RxString _messageNoti = ''.obs;
  String get messageNoti => _messageNoti.value;
  set messageNoti(String? value) => _messageNoti.value = value!.trim();

  @override
  void onInit() async {
    super.onInit();
    _student.value = authProvider.student;
    _isLoading.value = false;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    return null;
  }

  void sendNoti() async {
    if (formKey.currentState!.validate()) {
      SnackbarWidget.showSnackbar('Thành công');

      // _isLoading.value = true;
      // await authProvider.login(_email.value, _password.value);
      // _isLoading.value = false;
      // if (authProvider.isAuthenticated) {
      //   Get.offAllNamed(Routes.HOME);
      //   SnackbarWidget.showSnackbar(authProvider.responseMessage);
      // } else {
      //   SnackbarWidget.showSnackbar(authProvider.responseMessage);
      // }
    } else {
      SnackbarWidget.showSnackbar('Please enter valid credentials');
    }
  }
}
