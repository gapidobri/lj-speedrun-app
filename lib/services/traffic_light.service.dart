import 'package:chopper/chopper.dart';
import 'package:lj_speedrun/models/traffic_light.model.dart';

part 'traffic_light.service.chopper.dart';

@ChopperApi(baseUrl: "/traffic-lights")
abstract class TrafficLightService extends ChopperService {
  static TrafficLightService create([ChopperClient? client]) => _$TrafficLightService(client);

  @Get(path: '?populate=*')
  Future<Response<List<TrafficLight>>> getTrafficLights();
}
