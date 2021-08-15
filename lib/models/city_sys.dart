import 'package:json_annotation/json_annotation.dart';

part 'city_sys.g.dart';

@JsonSerializable()
class CitySys {
  int? sunrise;

  int? sunset;

  CitySys({
    this.sunrise,
    this.sunset,
  });

  factory CitySys.fromJson(Map<String, dynamic> json) =>
      _$CitySysFromJson(json);
  Map<String, dynamic> toJson() => _$CitySysToJson(this);
}
