part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weather;
  final List<WeatherModel> weatherHourly;
  final List<WeatherModel> weatherDaily;
  WeatherSuccess({
    required this.weather,
    required this.weatherHourly,
    required this.weatherDaily,
  });
}

final class WeatherFailed extends WeatherState {
  final String error;
  WeatherFailed(this.error);
}
