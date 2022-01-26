import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:lj_speedrun/models/location.model.dart';
import 'package:lj_speedrun/models/traffic_light.model.dart';
import 'package:lj_speedrun/services/json_serializable.converter.dart';
import 'package:lj_speedrun/services/traffic_light.service.dart';

class ChopperService {
  static void init() {
    final chopperClient = ChopperClient(
      baseUrl: 'http://ljspeedrun.gapi.me:1337/api',
      converter: const JsonSerializableConverter({
        TrafficLight: TrafficLight.fromJson,
        Location: Location.fromJson,
      }),
      services: [
        TrafficLightService.create(),
      ],
    );

    GetIt.I.registerSingleton<ChopperClient>(chopperClient);
  }
}
