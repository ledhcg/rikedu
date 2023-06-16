import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/notifications_and_sounds_controller.dart';

class NotificationsAndSoundsModal
    extends GetView<NotificationsAndSoundsController> {
  const NotificationsAndSoundsModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SwitchListTile(
            title: Text('Push Notifications'.tr),
            secondary:
                const Icon(FluentIcons.dual_screen_closed_alert_24_filled),
            onChanged: (isOn) {
              controller.changeSwitchPushNotifications();
            },
            value: controller.isPushNotifications,
          ),
          SwitchListTile(
            title: Text('Enable Sounds'.tr),
            secondary: const Icon(FluentIcons.alert_urgent_24_filled),
            onChanged: (isOn) {
              controller.changeSwitchEnableSounds();
            },
            value: controller.isEnableSounds,
          ),
        ],
      ),
    );
  }
}
