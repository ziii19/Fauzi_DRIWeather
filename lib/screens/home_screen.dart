import 'dart:ui';

import 'package:fauzi_driweather/core/constants/svg_assets.dart';
import 'package:fauzi_driweather/core/utils/date_format.dart';
import 'package:fauzi_driweather/core/utils/wind_speed_to_kmh.dart';
import 'package:fauzi_driweather/screens/blocs/location/location_cubit.dart';
import 'package:fauzi_driweather/screens/map_search_screen.dart';
import 'package:fauzi_driweather/screens/weather_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/weather_switch.dart';
import '../core/theme/app_color.dart';
import 'blocs/weather/weather_bloc.dart';
import 'widgets/bg_scaffold.dart';
import 'notification_sheet.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBottomSheetVisible = false;

  void _showNotificationModal(BuildContext context) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const NotificationBottomSheet();
      },
    ).then((_) {
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherSuccess) {
            final weather = state.weather;
            return BgScaffold(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MapSearchScreen.route(),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(SvgAssets.map),
                                    const SizedBox(width: 20),
                                    BlocBuilder<LocationCubit, LocationState>(
                                      builder: (context, state) {
                                        if (state is LocationSuccess) {
                                          return Text(
                                            state.locationName,
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.white,
                                            ),
                                          );
                                        }
                                        return const Text(
                                          'Surabaya',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.white,
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColor.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  _showNotificationModal(context);
                                },
                                icon: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: AppColor.white,
                                  size: 26,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Icon(
                        getWeatherIconAndDescription(
                            weather.weatherCode)['icon'],
                        color: AppColor.white,
                        size: 100,
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: 335,
                        height: 335,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatTimeMMMdd(weather.time),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${weather.temperature.toInt()}°',
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(2, 4),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              getWeatherIconAndDescription(
                                  weather.weatherCode)['description'],
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(Icons.air, color: Colors.white),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      '${convertWindSpeedToKmh(weather.windSpeed).toStringAsFixed(2)} km/h',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: 1,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                Column(
                                  children: [
                                    const Icon(Icons.water_drop,
                                        color: Colors.white),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Hum',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    Text(
                                      '${weather.humidity.toInt()}%',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WeatherScreen()));
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Weather Details'),
                              SizedBox(width: 11),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                              )
                            ],
                          ))
                    ],
                  ),
                  if (_isBottomSheetVisible)
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                      ),
                    ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
