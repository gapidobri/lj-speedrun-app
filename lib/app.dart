import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lj_speedrun/bloc/traffic_lights.bloc.dart';
import 'package:lj_speedrun/screens/map.screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<TrafficLightsBloc>(
        create: (context) => TrafficLightsBloc(),
        child: const MapScreen(),
      ),
    );
  }
}
