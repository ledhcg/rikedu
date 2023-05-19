import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/theme_controller.dart';

class ThemeModal extends GetView<ThemeController> {
  const ThemeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SwitchListTile(
          title: Text('Dark Mode'.tr),
          secondary: const Icon(FluentIcons.weather_moon_24_filled),
          onChanged: (isOn) {
            controller.setTheme(isOn);
            controller.setIsOn();
          },
          value: controller.isOn,
        ),
      ],
    );
  }
}
