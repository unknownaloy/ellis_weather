// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_temp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyTemp _$DailyTempFromJson(Map<String, dynamic> json) {
  return DailyTemp(
    min: (json['min'] as num?)?.toDouble(),
    max: (json['max'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$DailyTempToJson(DailyTemp instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
