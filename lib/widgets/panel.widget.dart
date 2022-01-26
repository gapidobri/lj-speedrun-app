import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lj_speedrun/bloc/traffic_lights.bloc.dart';
import 'package:lj_speedrun/bloc/traffic_lights.event.dart';
import 'package:lj_speedrun/bloc/traffic_lights.state.dart';

class PanelWidget extends StatelessWidget {
  const PanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrafficLightsBloc, TrafficLightsState>(
      builder: (context, state) {
        if (state is TrafficLightsInitial) {
          BlocProvider.of<TrafficLightsBloc>(context).add(FetchTrafficLights());
        } else if (state is TrafficLightsLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.lights.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) => Text(state.lights[i].name),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
