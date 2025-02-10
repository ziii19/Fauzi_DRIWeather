import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Color(0xff444E72),
        ),
      ),
    ),
    fontFamily: 'Overpass',
  );
}
