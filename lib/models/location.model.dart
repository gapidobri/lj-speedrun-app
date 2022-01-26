import 'package:json_annotation/json_annotation.dart';

part 'location.model.g.dart';

@JsonSerializable()
class Location {
  final String lat, lon;

  Location({
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}
