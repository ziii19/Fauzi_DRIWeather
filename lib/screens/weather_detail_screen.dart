import 'package:fauzi_driweather/core/constants/weather_switch.dart';
import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:fauzi_driweather/core/utils/date_format.dart';
import 'package:fauzi_driweather/screens/widgets/back_button.dart';
import 'package:fauzi_driweather/screens/widgets/bg_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/show_snackbar.dart';
import 'blocs/weather/weather_bloc.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SafeArea(
                      child: WidgetBack(),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          formatTimeMMMdd(state.weather.time),
                          style: const TextStyle(
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
                            .where((e) =>
                                DateTime.parse(e.time).day ==
                                DateTime.now().day)
                            .map(
                              (e) => WeatherHourlyItem(
                                time: formatTimeHHmm(e.time),
                                temp: '${e.temperature.toInt()}°',
                                icon: getWeatherIconAndDescription(
                                    e.weatherCode)['icon'],
                              ),
                            )
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
                    Column(
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
              ),
            );
          } else if (state is WeatherFailed) {
            showErrorDialog(context, state.error);
          }
          return const BgScaffold(child: SizedBox());
        },
      ),
    );
  }
}
