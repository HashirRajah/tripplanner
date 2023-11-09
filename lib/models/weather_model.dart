class WeatherModel {
  final String main;
  final String description;
  final double temp;
  final double feelsLike;
  final double min;
  final double max;
  final int humidity;
  final double wind;

  WeatherModel({
    required this.main,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.min,
    required this.max,
    required this.humidity,
    required this.wind,
  });
}
