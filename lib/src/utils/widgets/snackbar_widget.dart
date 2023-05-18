import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarWidget {
  static void showSnackbar(String message) {
    Get.snackbar(
      "Message",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      snackStyle: SnackStyle.FLOATING,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
