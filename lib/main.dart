import 'package:fauzi_driweather/core/theme/theme.dart';
import 'package:fauzi_driweather/screens/blocs/cubit/first_launch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/blocs/location/location_cubit.dart';
import 'screens/blocs/weather/weather_bloc.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc()),
        BlocProvider(
            create: (context) => LocationCubit()..getCurrentLocation()),
        BlocProvider(
            create: (context) => FirstLaunchCubit()..checkFirstLaunch()),
      ],
      child: const MainApp(),
    ),
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
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
