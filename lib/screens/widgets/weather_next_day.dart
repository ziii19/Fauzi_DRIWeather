import 'package:flutter/material.dart';

class WeatherNextDayItem extends StatelessWidget {
  final String date;
  final String temp;
  final IconData icon;

  const WeatherNextDayItem({
    super.key,
    required this.date,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Icon(icon, color: Colors.white),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                temp,
                style: const TextStyle(
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
}
