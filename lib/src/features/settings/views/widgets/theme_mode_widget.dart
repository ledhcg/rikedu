import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/providers/theme_mode.dart';

class SettingsModal extends StatefulWidget {
  const SettingsModal({super.key});

  @override
  _SettingsModalState createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  @override
  Widget build(BuildContext context) {
    final themeModeManager = Provider.of<ThemeModeManager>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SwitchListTile(
          title: const Text('Dark Mode'),
          secondary: const Icon(FluentIcons.weather_moon_24_filled),
          onChanged: (isOn) {
            if (isOn) {
              themeModeManager.setThemeModeType(ThemeModeType.dark);
            } else {
              themeModeManager.setThemeModeType(ThemeModeType.light);
            }
            Navigator.of(context).pop();
          },
          value: themeModeManager.themeModeType == ThemeModeType.dark,
        ),
      ],
    );
  }

  void _updateThemeMode(
    ThemeModeManager themeModeManager,
    bool isDarkMode,
  ) {
    const darkModeType = ThemeModeType.dark;
    const lightModeType = ThemeModeType.dark;
    if (isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      );
      themeModeManager.setThemeModeType(darkModeType);
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      themeModeManager.setThemeModeType(lightModeType);
    }
  }
}
