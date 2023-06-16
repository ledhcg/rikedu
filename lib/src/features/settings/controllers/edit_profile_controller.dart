import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/widgets/snackbar_widget.dart';

class EditProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiService _apiService = Get.find();

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  final fullNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final departmentController = TextEditingController();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _formChangePasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formChangePasswordKey => _formChangePasswordKey;

  final RxString _phoneText = ''.obs;
  String get phoneText => _phoneText.value;
  set phoneText(String? value) => _phoneText.value = value!.trim();

  final RxString _messageText = ''.obs;
  String get messageText => _messageText.value;
  set messageText(String? value) => _messageText.value = value!.trim();

  final RxString _dobText = ''.obs;
  String get dobText => _dobText.value;
  set dobText(String? value) => _dobText.value = value!.trim();

  final RxString _addressText = ''.obs;
  String get addressText => _addressText.value;
  set addressText(String? value) => _addressText.value = value!.trim();

  late AnimationController loadingController;
  final Rx<File?> _file = Rx<File?>(null);
  File? get file => _file.value;
  late final Rx<PlatformFile?> _platformFile = Rx<PlatformFile?>(null);
  PlatformFile? get platformFile => _platformFile.value;
  final RxDouble _loadingValue = 0.0.obs;
  double get loadingValue => _loadingValue.value;

  final RxBool _isLoadingUpdateAvatarSubmit = false.obs;
  bool get isLoadingUpdateAvatarSubmit => _isLoadingUpdateAvatarSubmit.value;

  final RxBool _isLoadingChangePassword = false.obs;
  bool get isLoadingChangePassword => _isLoadingChangePassword.value;

  final RxBool _isLoadingUpdateProfile = false.obs;
  bool get isLoadingUpdateProfile => _isLoadingUpdateProfile.value;

  final RxBool _isObscure = true.obs;
  bool get isObscure => _isObscure.value;
  final RxString _newPassword = ''.obs;
  String get newPassword => _newPassword.value;

  final RxString _confirmPassword = ''.obs;
  String get confirmPassword => _confirmPassword.value;

  final RxString _oldPassword = ''.obs;
  String get oldPassword => _oldPassword.value;

  final RxBool _isPasswordValid = false.obs;
  bool get isPasswordValid => _isPasswordValid.value;

  @override
  void onInit() async {
    super.onInit();
    _user.value = authProvider.user;
    await getDataFields();
    _isLoading.value = false;
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        update();
        _loadingValue.value = loadingController.value;
      });
  }

  void toggleObscure() {
    _isObscure.value = !_isObscure.value;
  }

  void setNewPassword(String? value) {
    _newPassword.value = value!.trim();
  }

  void setConfirmPassword(String? value) {
    _confirmPassword.value = value!.trim();
  }

  void setOldPassword(String? value) async {
    _oldPassword.value = value!.trim();
    final response =
        await _apiService.post("${ApiConst.USERS_ENDPOINT}/check-password", {
      'id': user.id,
      'password': oldPassword,
    });
    if (response.body['success']) {
      if (response.body['data']) {
        _isPasswordValid.value = true;
      } else {
        _isPasswordValid.value = false;
      }
    } else {
      _isPasswordValid.value = false;
    }
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

  String? checkOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (isPasswordValid) {
      return null;
    }
    return 'Password is not match current password.';
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    return null;
  }

  void updatePassword() async {
    if (formChangePasswordKey.currentState!.validate() &&
        newPassword == confirmPassword) {
      _isLoadingChangePassword.value = true;
      final response =
          await _apiService.post("${ApiConst.USERS_ENDPOINT}/update-password", {
        'id': user.id,
        'password': newPassword,
      });
      if (response.body['success']) {
        // ...
        resetChangePasswordFields();
        _isLoadingChangePassword.value = false;
        SnackbarWidget.showSnackbarSuccess(
            response.body['message'].toString().tr);
      } else {}
    } else {
      SnackbarWidget.showSnackbar(
          'Please enter valid credentials or New Password is not match Confirm Password');
    }
  }

  Future<void> getDataFields() async {
    fullNameController.text = user.fullName;
    usernameController.text = user.username;
    emailController.text = user.email;
    phoneController.text = user.phone;
    addressController.text = user.address;
    dobController.text = user.dateOfBirth.toString();
  }

  void selectPhoto() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        onFileLoading: (value) {},
        withReadStream: true);
    if (file != null) {
      _file.value = File(file.files.single.path!);
      _platformFile.value = file.files.first;
      updateAvatar();
    }
    loadingController.forward();
  }

  void updateAvatar() async {
    _isLoadingUpdateAvatarSubmit.value = true;
    try {
      String? filePath = platformFile!.path;
      File file = File(filePath!);
      String fileName = file.path.split('/').last;

      final formData = FormData({
        'image': MultipartFile(
          await file.readAsBytes(),
          filename: fileName,
        ),
        '_method': 'PUT',
      });
      final response = await _apiService.post(
          "${ApiConst.USERS_ENDPOINT}/${user.id}/update-avatar", formData);
      if (response.body['success']) {
        // Update info and reset data user
        // ...
        SnackbarWidget.showSnackbarSuccess(
            response.body['message'].toString().tr);
      } else {}
    } catch (e) {
      rethrow;
    }
    _isLoadingUpdateAvatarSubmit.value = false;
  }

  void resetChangePasswordFields() async {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
