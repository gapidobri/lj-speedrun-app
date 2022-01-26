// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_light.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrafficLight _$TrafficLightFromJson(Map<String, dynamic> json) => TrafficLight(
      name: json['name'] as String,
      captureTime: json['captureTime'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      interval: json['interval'] as int,
      seconds: json['seconds'] as int,
      greenLength: json['greenLength'] as int,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrafficLightToJson(TrafficLight instance) =>
    <String, dynamic>{
      'name': instance.name,
      'captureTime': instance.captureTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'seconds': instance.seconds,
      'interval': instance.interval,
      'greenLength': instance.greenLength,
      'location': instance.location,
    };
