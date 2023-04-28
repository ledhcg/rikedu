import 'package:flutter/material.dart';
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

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Google Sans',
    primaryColor: rikePrimaryColor,
    brightness: Brightness.light,
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
    filledButtonTheme: lightFilledButtonTheme,
    inputDecorationTheme: lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Google Sans',
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
}
