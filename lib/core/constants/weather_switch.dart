import 'package:weather_icons/weather_icons.dart';

Map<int, Map<String, dynamic>> weatherData = {
  0: {
    'icon': WeatherIcons.day_cloudy,
    'description': 'Unknown',
  },
  1000: {
    'icon': WeatherIcons.day_sunny,
    'description': 'Clear',
  },
  1100: {
    'icon': WeatherIcons.day_sunny_overcast,
    'description': 'Mostly Clear',
  },
  1101: {
    'icon': WeatherIcons.day_cloudy,
    'description': 'Partly Cloudy',
  },
  1102: {
    'icon': WeatherIcons.cloudy,
    'description': 'Cloudy',
  },
  1001: {
    'icon': WeatherIcons.cloudy,
    'description': 'Cloudy',
  },
  2000: {
    'icon': WeatherIcons.fog,
    'description': 'Fog',
  },
  2100: {
    'icon': WeatherIcons.day_fog,
    'description': 'Light Fog',
  },
  4000: {
    'icon': WeatherIcons.sprinkle,
    'description': 'Drizzle',
  },
  4200: {
    'icon': WeatherIcons.showers,
    'description': 'Light Rain',
  },
  4001: {
    'icon': WeatherIcons.rain,
    'description': 'Rain',
  },
  4201: {
    'icon': WeatherIcons.rain,
    'description': 'Heavy Rain',
  },
  5000: {
    'icon': WeatherIcons.snow,
    'description': 'Snow',
  },
  5001: {
    'icon': WeatherIcons.snowflake_cold,
    'description': 'Flurries',
  },
  5100: {
    'icon': WeatherIcons.day_snow,
    'description': 'Light Snow',
  },
  5101: {
    'icon': WeatherIcons.snow,
    'description': 'Heavy Snow',
  },
  6000: {
    'icon': WeatherIcons.sleet,
    'description': 'Freezing Drizzle',
  },
  6001: {
    'icon': WeatherIcons.rain_mix,
    'description': 'Freezing Rain',
  },
  6200: {
    'icon': WeatherIcons.day_sleet,
    'description': 'Light Freezing Rain',
  },
  6201: {
    'icon': WeatherIcons.sleet,
    'description': 'Heavy Freezing Rain',
  },
  7000: {
    'icon': WeatherIcons.sleet,
    'description': 'Ice Pellets',
  },
  7101: {
    'icon': WeatherIcons.sleet,
    'description': 'Heavy Ice Pellets',
  },
  7102: {
    'icon': WeatherIcons.day_sleet,
    'description': 'Light Ice Pellets',
  },
  8000: {
    'icon': WeatherIcons.thunderstorm,
    'description': 'Thunderstorm',
  },
};

Map<String, dynamic> getWeatherIconAndDescription(int weatherCode) {
  return weatherData[weatherCode] ?? {
    'icon': WeatherIcons.day_cloudy,
    'description': 'Unknown',
  };
}
