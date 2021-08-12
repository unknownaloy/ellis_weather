import 'package:ellis_weather/models/current.dart';
import 'package:ellis_weather/models/daily.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherData {
  Current? current;
  List<Daily>? daily;

  WeatherData({
    this.current,
    this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}
