import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/sizes.dart';

class RikeTheme {
  RikeTheme._();

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

  static ThemeData lightTheme = ThemeData(
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
  static ThemeData darkTheme = ThemeData(
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
