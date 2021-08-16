import 'package:ellis_weather/models/city_main.dart';
import 'package:ellis_weather/models/city_sys.dart';
import 'package:ellis_weather/models/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_weather_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CityWeatherData {
  List<Weather>? weather;

  @JsonKey(name: "main")
  CityMain? cityMain;

  @JsonKey(name: "sys")
  CitySys? citySys;

  @JsonKey(name: "dt")
  int? dateTime;

  CityWeatherData({
    this.weather,
    this.cityMain,
    this.citySys,
    this.dateTime,
  });

  factory CityWeatherData.fromJson(Map<String, dynamic> json) =>
      _$CityWeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$CityWeatherDataToJson(this);
}
