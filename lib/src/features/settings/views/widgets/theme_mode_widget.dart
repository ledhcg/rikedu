import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/sizes.dart';
import 'package:rikedu/src/providers/theme_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // Navigator.of(context).pop();
  }
}

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildHandleBar(context), if (child != null) child],
      ),
    );
  }

  Widget _buildHandleBar(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      widthFactor: 0.10,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
