class WeatherModel {
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final double humidity;
  final String time;

  WeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.humidity,
    required this.time,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final values = json['values'];

    return WeatherModel(
      temperature: (values['temperature'] ?? 0.0).toDouble(),
      weatherCode: values['weatherCode'] ?? 0,
      windSpeed: (values['windSpeed'] ?? 0.0).toDouble(),
      humidity: (values['humidity'] ?? 0.0).toDouble(),
      time: json['time'] ?? '',
    );
  }
  factory WeatherModel.dailyFromJson(Map<String, dynamic> json) {
    final values = json['values'];

    return WeatherModel(
      temperature: (values['temperatureAvg'] ?? 0.0).toDouble(),
      weatherCode: values['weatherCode'] ?? 0,
      windSpeed: (values['windSpeedAvg'] ?? 0.0).toDouble(),
      humidity:
          (values['humidityAvg'] ?? 0.0).toDouble(),
      time: json['time'] ?? '',
    );
  }
}
