import 'package:fauzi_driweather/core/constants/weather_switch.dart';
import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:fauzi_driweather/core/utils/date_format.dart';
import 'package:fauzi_driweather/screens/widgets/back_button.dart';
import 'package:fauzi_driweather/screens/widgets/bg_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';

import 'bloc/weather_bloc.dart';
import 'widgets/weather_hourly.dart';
import 'widgets/weather_next_day.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherSuccess) {
            return BgScaffold(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SafeArea(
                    child: WidgetBack(),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'Sep, 12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: state.weatherHourly
                          .map((e) => WeatherHourlyItem(
                              time: formatTimeHHmm(e.time),
                              temp: '${e.temperature.toInt()}°',
                              icon: getWeatherIconAndDescription(
                                  e.weatherCode)['icon']))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next Forecast',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: AppColor.white,
                        size: 20,
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: state.weatherDaily
                          .map(
                            (e) => WeatherNextDayItem(
                              date: formatTimeMMMdd(e.time),
                              temp: '${e.temperature.toInt()}°',
                              icon: getWeatherIconAndDescription(
                                  e.weatherCode)['icon'],
                            ),
                          )
                          .toList(),
                      // const [
                      //   WeatherNextDayItem(
                      //       date: 'Sep, 14',
                      //       temp: '22°',
                      //       icon: WeatherIcons.day_cloudy_windy),
                      //   WeatherNextDayItem(
                      //       date: 'Sep, 15',
                      //       temp: '34°',
                      //       icon: WeatherIcons.day_cloudy_windy),
                      //   WeatherNextDayItem(
                      //       date: 'Sep, 16',
                      //       temp: '27°',
                      //       icon: WeatherIcons.day_cloudy_windy),
                      //   WeatherNextDayItem(
                      //       date: 'Sep, 17',
                      //       temp: '32°',
                      //       icon: WeatherIcons.day_cloudy_windy),
                      // ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'DRI Weather',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
