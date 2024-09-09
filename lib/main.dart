import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:flutter/material.dart';

import 'features/weather/presentation/pages/onboard_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff444E72),
            ),
          ),
        ),
        fontFamily: 'Overpass',
      ),
      home: const OnboardPage(),
    );
  }
}
