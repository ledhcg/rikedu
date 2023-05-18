import 'package:flutter/material.dart';
import 'package:rikedu/src/config/themes/dark_theme.dart';
import 'package:rikedu/src/config/themes/light_theme.dart';

class RikeTheme {
  RikeTheme._();
  static ThemeData lightTheme = LightTheme.themeData;
  static ThemeData darkTheme = DarkTheme.themeData;
}
