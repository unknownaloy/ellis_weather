import 'package:json_annotation/json_annotation.dart';

part 'daily_weather_icon.g.dart';

@JsonSerializable()
class DailyWeatherIcon {
  String? icon;

  DailyWeatherIcon({
    this.icon,
  });

  factory DailyWeatherIcon.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherIconFromJson(json);
  Map<String, dynamic> toJson() => _$DailyWeatherIconToJson(this);
}
