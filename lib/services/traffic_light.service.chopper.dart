// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_light.service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TrafficLightService extends TrafficLightService {
  _$TrafficLightService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TrafficLightService;

  @override
  Future<Response<List<TrafficLight>>> getTrafficLights() {
    final $url = '/traffic-lights/?populate=*';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<TrafficLight>, TrafficLight>($request);
  }
}
