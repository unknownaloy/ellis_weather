import 'package:json_annotation/json_annotation.dart';

part 'daily_temp.g.dart';

@JsonSerializable()
class DailyTemp {
  double? min;
  double? max;

  DailyTemp({
    this.min,
    this.max,
  });

  factory DailyTemp.fromJson(Map<String, dynamic> json) =>
      _$DailyTempFromJson(json);
  Map<String, dynamic> toJson() => _$DailyTempToJson(this);
}
