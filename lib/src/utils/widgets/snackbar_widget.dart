import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';

class SnackbarWidget {
  static void showSnackbar(String message) {
    Get.snackbar(
      "Message",
      message,
      icon: const Icon(FluentIcons.checkmark_circle_24_regular),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 20,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  static void showSnackbarSuccess(String message) {
    Get.snackbar(
      "Success".tr,
      message,
      icon: Lottie.asset(FilesConst.LOTTIE_SUCCESS),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF39B54A),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 20,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
