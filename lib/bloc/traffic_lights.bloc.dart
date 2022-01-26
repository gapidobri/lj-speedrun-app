import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lj_speedrun/bloc/traffic_lights.event.dart';
import 'package:lj_speedrun/bloc/traffic_lights.state.dart';
import 'package:lj_speedrun/services/traffic_light.service.dart';

final chopper = GetIt.I.get<ChopperClient>();
final trafficLightService = chopper.getService<TrafficLightService>();

class TrafficLightsBloc extends Bloc<TrafficLightsEvent, TrafficLightsState> {
  TrafficLightsBloc() : super(TrafficLightsInitial()) {
    on<FetchTrafficLights>(_onFetch);
  }

  void _onFetch(TrafficLightsEvent event, Emitter<TrafficLightsState> emit) async {
    emit(TrafficLightsLoading());

    final response = await trafficLightService.getTrafficLights();

    if (response.body == null) {
      print('Error');
      emit(TrafficLightsError('Failed to fetch traffic lights'));

      return;
    }

    emit(TrafficLightsLoaded(response.body!));
  }
}
