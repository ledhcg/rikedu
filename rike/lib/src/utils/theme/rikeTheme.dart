import 'package:flutter/material.dart';

class RikeTheme {
  RikeTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    fontFamily: 'Google Sans',
    // textTheme: const TextTheme(
    //   displayLarge: customTextStyle,
    //   displayMedium: TextStyle(fontFamily: 'Google Sans'),
    // ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Google Sans',
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
}
