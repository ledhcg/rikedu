import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { light, dark }

class ThemeModeManager extends ChangeNotifier {
  ThemeModeType _themeModeType = ThemeModeType.light;

  ThemeModeType get themeModeType => _themeModeType;

  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final themeModeTypeString = sharedPreferences.getString('themeModeType');
    if (themeModeTypeString != null) {
      _themeModeType = ThemeModeType.values
          .firstWhere((e) => e.toString() == themeModeTypeString);
    }
  }

  Future<void> setThemeModeType(ThemeModeType themeModeType) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        'themeModeType', themeModeType.toString());
    _themeModeType = themeModeType;
    notifyListeners();
  }
}
