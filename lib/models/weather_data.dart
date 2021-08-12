import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  int? temperature;
  String? weatherIcon;
  String? description;
  String? weatherMessage;
  int? feelsLike;
  int? humidity;
  String? sunriseTime;
  String? sunsetTime;
  String? currentDateTime;

  WeatherData({
    this.temperature,
    this.weatherIcon,
    this.description,
    this.weatherMessage,
    this.feelsLike,
    this.humidity,
    this.sunriseTime,
    this.sunsetTime,
    this.currentDateTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}
