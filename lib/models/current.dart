import 'package:ellis_weather/models/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'current.g.dart';

@JsonSerializable(explicitToJson: true)
class Current {
  int? sunrise;
  int? sunset;
  double? temp;
  int? humidity;
  List<Weather>? weather;

  @JsonKey(name: "feels_like")
  double? feelsLike;

  @JsonKey(name: "dt")
  int? dateTime;

  Current({
    this.sunrise,
    this.sunset,
    this.temp,
    this.humidity,
    this.weather,
    this.feelsLike,
    this.dateTime,
  });

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}
