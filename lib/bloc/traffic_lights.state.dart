import 'package:equatable/equatable.dart';
import 'package:lj_speedrun/models/traffic_light.model.dart';

abstract class TrafficLightsState extends Equatable {}

class TrafficLightsInitial extends TrafficLightsState {
  @override
  List<Object?> get props => [];
}

class TrafficLightsLoading extends TrafficLightsState {
  @override
  List<Object?> get props => [];
}

class TrafficLightsLoaded extends TrafficLightsState {
  TrafficLightsLoaded(this.lights);

  final List<TrafficLight> lights;

  @override
  List<Object?> get props => [
        lights,
      ];
}

class TrafficLightsError extends TrafficLightsState {
  TrafficLightsError(this.message);

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}
