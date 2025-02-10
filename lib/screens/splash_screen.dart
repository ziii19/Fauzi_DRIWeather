import 'package:fauzi_driweather/core/utils/show_snackbar.dart';
import 'package:fauzi_driweather/screens/blocs/cubit/first_launch_cubit.dart';
import 'package:fauzi_driweather/screens/blocs/weather/weather_bloc.dart';
import 'package:fauzi_driweather/screens/home_screen.dart';
import 'package:fauzi_driweather/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/location/location_cubit.dart';
import 'widgets/bg_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationSuccess) {
              context.read<WeatherBloc>().add(GetRealtimWeather(
                  lat: state.currentLocation.latitude,
                  lon: state.currentLocation.longitude));
            }
          },
        ),
        BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherSuccess) {
              final isFirstLaunchCubit = context.read<FirstLaunchCubit>();
              isFirstLaunchCubit.state
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnboardPage()),
                      (route) => false,
                    )
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
            } else if (state is WeatherFailed) {
              showErrorDialogClose(context, state.error);
            }
          },
        ),
      ],
      child: Scaffold(
        body: BgScaffold(
          child: Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Weather Now',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your trusted weather forecast',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
