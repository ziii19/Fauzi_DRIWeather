import 'dart:convert';
import 'package:fauzi_driweather/core/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String _apiKey = 'OQFVHu6SnGhkuqrJb34dYqmfgAmukCPu';

  Future<WeatherModel?> getRealtimeWeather(double lat, double lon) async {
    String url =
        'https://api.tomorrow.io/v4/weather/realtime?location=$lat,$lon&apikey=$_apiKey';
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<WeatherModel>?> getWeatherDataByTimestep(
      {required double latitude,
      required double longitude,
      required bool isDaily}) async {
    final url =
        'https://api.tomorrow.io//v4/weather/forecast?location=$latitude,$longitude&timesteps=${isDaily ? '1d' : '1h'}&apikey=$_apiKey';
    final response = await http.get(Uri.parse(url));
    final weather = json.decode(response.body)['timelines']
        [isDaily ? 'daily' : 'hourly'] as List;

    if (response.statusCode == 200) {
      return isDaily
          ? weather.map((e) => WeatherModel.dailyFromJson(e)).toList()
          : weather.map((e) => WeatherModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
