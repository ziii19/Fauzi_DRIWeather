part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetRealtimWeather extends WeatherEvent {
  final double lat;
  final double lon;

  GetRealtimWeather({required this.lat, required this.lon});
}
