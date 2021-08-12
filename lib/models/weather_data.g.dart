// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherData _$WeatherDataFromJson(Map<String, dynamic> json) {
  return WeatherData(
    temperature: json['temperature'] as int?,
    weatherIcon: json['weatherIcon'] as String?,
    description: json['description'] as String?,
    weatherMessage: json['weatherMessage'] as String?,
    feelsLike: json['feelsLike'] as int?,
    humidity: json['humidity'] as int?,
    sunriseTime: json['sunriseTime'] as String?,
    sunsetTime: json['sunsetTime'] as String?,
    currentDateTime: json['currentDateTime'] as String?,
  );
}

Map<String, dynamic> _$WeatherDataToJson(WeatherData instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'weatherIcon': instance.weatherIcon,
      'description': instance.description,
      'weatherMessage': instance.weatherMessage,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'sunriseTime': instance.sunriseTime,
      'sunsetTime': instance.sunsetTime,
      'currentDateTime': instance.currentDateTime,
    };
