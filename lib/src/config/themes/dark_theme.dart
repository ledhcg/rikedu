import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';

class DarkTheme {
  static ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: rikePrimaryColorDark,
    onPrimary: rikeOnPrimaryColorDark,
    primaryContainer: rikePrimaryContainerColorDark,
    secondary: rikeSecondaryColorDark,
    onSecondary: rikeOnSecondaryColorDark,
    scrim: rikeScrimColoDark,
    surface: rikeSurfaceColoDark,
    onSurface: rikeOnSurfaceColoDark,
    error: rikeErrorColorDark,
    onError: rikeOnErrorColorDark,
    background: rikeBackgroundColorDark,
    onBackground: rikeOnBackgroundColorDark,
  );
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'Google Sans',
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    ),
  );
}
