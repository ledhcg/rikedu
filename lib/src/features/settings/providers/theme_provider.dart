import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

enum ThemeModeType { light, dark }

class ThemeProvider extends ChangeNotifier {
  final StorageService _storageService = Get.find();
  ThemeModeType _themeModeType = ThemeModeType.light;
  bool _isDarkMode = false;

  ThemeModeType get themeModeType => _themeModeType;
  bool get isDarkMode => _isDarkMode;

  Future<void> init() async {
    final themeModeTypeString =
        _storageService.readData(StorageConst.SETTING_THEME_MODE);

    if (themeModeTypeString != null) {
      _themeModeType = ThemeModeType.values
          .firstWhere((e) => e.toString() == themeModeTypeString);
    }
    _isDarkMode = checkIsDarkMode(_themeModeType);
  }

  bool checkIsDarkMode(ThemeModeType themeModeType) {
    return themeModeType == ThemeModeType.dark ? true : false;
  }

  Future<void> setThemeModeType(ThemeModeType themeModeType) async {
    _storageService.writeData(
        StorageConst.SETTING_THEME_MODE, themeModeType.toString());
    _themeModeType = themeModeType;
    _isDarkMode = checkIsDarkMode(_themeModeType);
    updateSystemUI();
    notifyListeners();
  }

  Future<void> updateSystemUI() async {
    Brightness statusBarIconBrightness =
        isDarkMode ? Brightness.light : Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    );
  }

  Future<void> setLightIconStatusBar() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  Future<void> setDarkIconStatusBar() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
