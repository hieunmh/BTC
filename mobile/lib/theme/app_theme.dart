import 'package:flutter/material.dart';

class AppTheme {

  //light theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    )
  );

  //light theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromRGBO(38, 38, 38, 1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(38, 38, 38, 1)
    )
  );
}