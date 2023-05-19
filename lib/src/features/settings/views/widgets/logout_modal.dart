import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/logout_controller.dart';

class LogoutModal extends GetView<LogoutController> {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text('Are you sure you want to log out?'.tr),
            ),
          ),
          FilledButton(
            onPressed: controller.logout,
            child: Text('Confirm'.tr),
          ),
        ],
      ),
    );
  }
}
