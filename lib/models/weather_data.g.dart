// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
    current: json['current'] == null
        ? null
        : Current.fromJson(json['current'] as Map<String, dynamic>),
    daily: (json['daily'] as List<dynamic>?)
        ?.map((e) => Daily.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'current': instance.current?.toJson(),
      'daily': instance.daily?.map((e) => e.toJson()).toList(),
    };
