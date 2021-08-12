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
    dateTime: json['dt'] as int?,
  );
}

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'humidity': instance.humidity,
      'temp': instance.dailyTemp?.toJson(),
      'dt': instance.dateTime,
    };
