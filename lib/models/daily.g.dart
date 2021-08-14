// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Daily _$DailyFromJson(Map<String, dynamic> json) {
  return Daily(
    humidity: json['humidity'] as int?,
    dailyTemp: json['temp'] == null
        ? null
        : DailyTemp.fromJson(json['temp'] as Map<String, dynamic>),
    dailyWeather: (json['weather'] as List<dynamic>?)
        ?.map((e) => DailyWeatherIcon.fromJson(e as Map<String, dynamic>))
        .toList(),
    dateTime: json['dt'] as int?,
  );
}

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'humidity': instance.humidity,
      'temp': instance.dailyTemp?.toJson(),
      'weather': instance.dailyWeather?.map((e) => e.toJson()).toList(),
      'dt': instance.dateTime,
    };
