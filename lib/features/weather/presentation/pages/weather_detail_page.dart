import 'package:fauzi_driweather/core/theme/app_color.dart';
import 'package:fauzi_driweather/features/weather/presentation/widgets/back_button.dart';
import 'package:fauzi_driweather/features/weather/presentation/widgets/bg_scaffold.dart';
import 'package:flutter/material.dart';

import '../widgets/weather_hourly.dart';
import '../widgets/weather_next_day.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgScaffold(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherHourlyItem(
                    time: '15.00', temp: '29°C', icon: Icons.wb_cloudy),
                WeatherHourlyItem(
                    time: '16.00', temp: '26°C', icon: Icons.wb_cloudy),
                WeatherHourlyItem(
                    time: '17.00', temp: '24°C', icon: Icons.cloud),
                WeatherHourlyItem(
                    time: '18.00', temp: '23°C', icon: Icons.wb_cloudy),
                WeatherHourlyItem(
                    time: '19.00', temp: '22°C', icon: Icons.wb_cloudy),
              ],
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
                children: const [
                  WeatherNextDayItem(
                      date: 'Sep, 13', temp: '21°', icon: Icons.wb_cloudy),
                  WeatherNextDayItem(
                      date: 'Sep, 14', temp: '22°', icon: Icons.cloud),
                  WeatherNextDayItem(
                      date: 'Sep, 15', temp: '34°', icon: Icons.wb_sunny),
                  WeatherNextDayItem(
                      date: 'Sep, 16', temp: '27°', icon: Icons.wb_cloudy),
                  WeatherNextDayItem(
                      date: 'Sep, 17', temp: '32°', icon: Icons.wb_cloudy),
                ],
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
      ),
    );
  }
}
