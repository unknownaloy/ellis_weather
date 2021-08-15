// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityMain _$CityMainFromJson(Map<String, dynamic> json) {
  return CityMain(
    temp: (json['temp'] as num?)?.toDouble(),
    humidity: json['humidity'] as int?,
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    minTemp: (json['temp_min'] as num?)?.toDouble(),
    maxTemp: (json['temp_max'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$CityMainToJson(CityMain instance) => <String, dynamic>{
      'temp': instance.temp,
      'humidity': instance.humidity,
      'feels_like': instance.feelsLike,
      'temp_min': instance.minTemp,
      'temp_max': instance.maxTemp,
    };
