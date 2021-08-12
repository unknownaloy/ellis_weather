import 'package:ellis_weather/models/daily_temp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily.g.dart';

@JsonSerializable(explicitToJson: true)
class Daily {
  int? humidity;

  @JsonKey(name: "temp")
  DailyTemp? dailyTemp;

  @JsonKey(name: "dt")
  int? dateTime;

  Daily({
    this.humidity,
    this.dailyTemp,
    this.dateTime,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
