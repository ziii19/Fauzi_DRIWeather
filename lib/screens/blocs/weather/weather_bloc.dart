import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/weather_model.dart';
import '../../../services/weather_api.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((_, emit) => WeatherLoading());
    on<GetRealtimWeather>((event, emit) async {
      try {
        final weather = await WeatherApi().getRealtimeWeather(
          event.lat,
          event.lon,
        );

        final weatherHourly = await WeatherApi().getWeatherDataByTimestep(
            latitude: event.lat, longitude: event.lon, isDaily: false);

        final weatherDaily = await WeatherApi().getWeatherDataByTimestep(
            latitude: event.lat, longitude: event.lon, isDaily: true);

        emit(
          WeatherSuccess(
            weather: weather!,
            weatherHourly: weatherHourly!,
            weatherDaily: weatherDaily!,
          ),
        );
      } catch (e) {
        emit(WeatherFailed('Failed to load weather data'));
      }
    });
  }
}
