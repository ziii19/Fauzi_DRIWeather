import 'package:flutter/material.dart';

class WeatherHourlyItem extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const WeatherHourlyItem(
      {super.key, required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Icon(icon, color: Colors.white),
          const SizedBox(height: 20),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
