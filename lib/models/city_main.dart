import 'package:json_annotation/json_annotation.dart';

part 'city_main.g.dart';

@JsonSerializable()
class CityMain {
  double? temp;

  int? humidity;

  @JsonKey(name: "feels_like")
  double? feelsLike;

  @JsonKey(name: "temp_min")
  double? minTemp;

  @JsonKey(name: "temp_max")
  double? maxTemp;

  CityMain({
    this.temp,
    this.humidity,
    this.feelsLike,
    this.minTemp,
    this.maxTemp,
  });

  factory CityMain.fromJson(Map<String, dynamic> json) =>
      _$CityMainFromJson(json);
  Map<String, dynamic> toJson() => _$CityMainToJson(this);
}
