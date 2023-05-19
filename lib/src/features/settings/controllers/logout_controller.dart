import 'dart:convert';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class LogoutController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);
  final StorageService _storageService = Get.find();

  late final String userId;

  @override
  void onInit() {
    super.onInit();
    userId = getId();
  }

  String getId() {
    final userJson = User.fromJson(
        jsonDecode(_storageService.readData(StorageConst.USER_DATA)));
    return userJson.id.toString();
  }

  void logout() {
    authProvider.logout(userId);
    Get.offAllNamed(Routes.LOGIN);
  }
}
