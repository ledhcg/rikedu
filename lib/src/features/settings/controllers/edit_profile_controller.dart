import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';

class EditProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
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

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

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

  @override
  void onInit() async {
    super.onInit();
    _user.value = authProvider.student;
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

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    return null;
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
    }
    loadingController.forward();
  }
}
