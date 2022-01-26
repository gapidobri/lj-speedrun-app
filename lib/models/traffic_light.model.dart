import 'package:json_annotation/json_annotation.dart';

import 'location.model.dart';

part 'traffic_light.model.g.dart';

@JsonSerializable()
class TrafficLight {
  final String name, captureTime;
  final DateTime createdAt, updatedAt;
  final int seconds, interval, greenLength;
  final Location location;

  TrafficLight({
    required this.name,
    required this.captureTime,
    required this.createdAt,
    required this.updatedAt,
    required this.interval,
    required this.seconds,
    required this.greenLength,
    required this.location,
  });

  factory TrafficLight.fromJson(Map<String, dynamic> json) => _$TrafficLightFromJson(json);
}
