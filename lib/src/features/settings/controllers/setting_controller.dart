import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/utils/constants/keys_storage_constants.dart';

class SettingsController extends GetxController {
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

  User get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    GetStorage.init();
    getUser();
  }

  void getUser() async {
    try {
      final userJson =
          jsonDecode(await localStorage.read(KeysStorageConst.USER_DATA));
      if (userJson != null) {
        _user.value = User.fromJson(userJson);
      }
    } catch (e) {
      rethrow;
    }
  }
}
