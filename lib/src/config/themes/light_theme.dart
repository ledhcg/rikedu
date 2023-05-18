import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rikedu/src/utils/constants/colors.dart';
import 'package:rikedu/src/utils/constants/sizes.dart';

class LightTheme {
  static FilledButtonThemeData lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
        backgroundColor: rikePrimaryColor,
        padding: const EdgeInsets.symmetric(vertical: p1)),
  );

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    prefixIconColor: rikePrimaryColor,
    suffixIconColor: rikePrimaryColor,
    labelStyle: TextStyle(
      color: rikePrimaryColor,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: rikePrimaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(color: rikePrimaryColor),
    ),
  );

  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: rikePrimaryColorLight,
    onPrimary: rikeOnPrimaryColorLight,
    primaryContainer: rikePrimaryContainerColorLight,
    secondary: rikeSecondaryColorLight,
    onSecondary: rikeOnSecondaryColorLight,
    scrim: rikeScrimColoLight,
    surface: rikeSurfaceColoLight,
    onSurface: rikeOnSurfaceColoLight,
    error: rikeErrorColorLight,
    onError: rikeOnErrorColorLight,
    background: rikeBackgroundColorLight,
    onBackground: rikeOnBackgroundColorLight,
  );

  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'Google Sans',
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
