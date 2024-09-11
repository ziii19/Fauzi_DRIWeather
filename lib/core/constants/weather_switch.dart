import 'package:weather_icons/weather_icons.dart';

Map<String, dynamic> getWeatherIconAndDescription(int weatherCode) {
  switch (weatherCode) {
    case 0:
      return {
        'icon': WeatherIcons.day_sunny,
        'description': 'Clear sky',
      };

    case 1000:
      return {
        'icon': WeatherIcons.day_sunny_overcast,
        'description': 'Mostly clear',
      };

    case 1101:
      return {
        'icon': WeatherIcons.day_cloudy,
        'description': 'Partly cloudy',
      };

    case 1102:
      return {
        'icon': WeatherIcons.cloudy,
        'description': 'Cloudy',
      };

    case 2000:
      return {
        'icon': WeatherIcons.fog,
        'description': 'Fog',
      };

    case 2100:
      return {
        'icon': WeatherIcons.day_fog,
        'description': 'Light fog',
      };

    case 4000:
      return {
        'icon': WeatherIcons.sprinkle,
        'description': 'Drizzle',
      };

    case 4200:
      return {
        'icon': WeatherIcons.showers,
        'description': 'Light rain',
      };

    case 4001:
      return {
        'icon': WeatherIcons.rain,
        'description': 'Rain',
      };

    case 4201:
      return {
        'icon': WeatherIcons.rain,
        'description': 'Heavy rain',
      };

    case 5000:
      return {
        'icon': WeatherIcons.snow,
        'description': 'Snow',
      };

    case 5100:
      return {
        'icon': WeatherIcons.day_snow,
        'description': 'Light snow',
      };

    case 6000:
      return {
        'icon': WeatherIcons.sleet,
        'description': 'Freezing drizzle',
      };

    case 7000:
      return {
        'icon': WeatherIcons.thunderstorm,
        'description': 'Thunderstorm',
      };

    case 5101:
      return {
        'icon': WeatherIcons.snow,
        'description': 'Heavy snow',
      };

    case 6200:
      return {
        'icon': WeatherIcons.day_sleet,
        'description': 'Light sleet',
      };

    case 6201:
      return {
        'icon': WeatherIcons.sleet,
        'description': 'Heavy sleet',
      };

    default:
      return {
        'icon': WeatherIcons.day_cloudy,
        'description': 'Unknown',
      };
  }
}
