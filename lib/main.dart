import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/blocs/cubit/location_cubit.dart';
import 'screens/blocs/weather/weather_bloc.dart';
import 'screens/splash_screen.dart';

void main() async {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => WeatherBloc()),
      BlocProvider(create: (context) => LocationCubit()..getCurrentLocation()),
    ], child: const MainApp()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
      ),
      home: const SplashScreen(),
    );
  }
}
