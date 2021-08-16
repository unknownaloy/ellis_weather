// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityWeatherData _$CityWeatherDataFromJson(Map<String, dynamic> json) {
  return CityWeatherData(
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    cityMain: json['main'] == null
        ? null
        : CityMain.fromJson(json['main'] as Map<String, dynamic>),
    citySys: json['sys'] == null
        ? null
        : CitySys.fromJson(json['sys'] as Map<String, dynamic>),
    dateTime: json['dt'] as int?,
  );
}

Map<String, dynamic> _$CityWeatherDataToJson(CityWeatherData instance) =>
    <String, dynamic>{
      'weather': instance.weather?.map((e) => e.toJson()).toList(),
      'main': instance.cityMain?.toJson(),
      'sys': instance.citySys?.toJson(),
      'dt': instance.dateTime,
    };
