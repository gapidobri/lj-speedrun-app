import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lj_speedrun/bloc/traffic_lights.bloc.dart';
import 'package:lj_speedrun/bloc/traffic_lights.event.dart';
import 'package:lj_speedrun/bloc/traffic_lights.state.dart';
import 'package:lj_speedrun/models/traffic_light.model.dart';
import 'package:lj_speedrun/widgets/countdown.widget.dart';
import 'package:location/location.dart';

const initialCameraPosition = CameraPosition(
  target: LatLng(0, 0),
);

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late final GoogleMapController _controller;

  List<ScreenCoordinate> _screenCoordinates = [];

  Set<Marker> _buildMarkers(List<TrafficLight> lights) => lights
      .map(
        (light) => Marker(
          markerId: MarkerId(light.name),
          position: LatLng(
            double.parse(light.location.lat),
            double.parse(light.location.lon),
          ),
        ),
      )
      .toSet();

  List<Widget> _buildCounters(List<TrafficLight> lights) {
    final dpr = MediaQuery.of(context).devicePixelRatio;

    if (_screenCoordinates.isEmpty) {
      return [];
    }

    return lights.map((light) {
      final i = lights.indexOf(light);
      return Positioned(
        left: _screenCoordinates[i].x.toDouble() / dpr,
        top: _screenCoordinates[i].y.toDouble() / dpr,
        child: CountdownWidget(light: light),
      );
    }).toList();
  }

  void _onMapCreated(GoogleMapController controller, List<TrafficLight> lights) async {
    _controller = controller;

    final location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final currentLocation = await location.getLocation();
    final target = LatLng(
      currentLocation.latitude ?? 0,
      currentLocation.longitude ?? 0,
    );

    // TODO: Save last location in shared preferences

    controller.moveCamera(CameraUpdate.newLatLngZoom(target, 18.0));

    _onCameraMove(CameraPosition(target: target), lights);

    // location.onLocationChanged.listen(_onLocationChanged);
  }

  void _onLocationChanged(LocationData currentLocation) async {
    // print('${currentLocation.latitude} ${currentLocation.longitude}');
  }

  void _onCameraMove(CameraPosition cameraPosition, List<TrafficLight> lights) async {
    final futures = lights
        .map(
          (light) => _controller.getScreenCoordinate(
            LatLng(
              double.parse(light.location.lat),
              double.parse(light.location.lon),
            ),
          ),
        )
        .toList();

    _screenCoordinates = await Future.wait(futures);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrafficLightsBloc, TrafficLightsState>(
      builder: (context, state) {
        if (state is TrafficLightsInitial) {
          BlocProvider.of<TrafficLightsBloc>(context).add(FetchTrafficLights());
        } else if (state is TrafficLightsLoaded) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: initialCameraPosition,
                myLocationButtonEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: true,
                buildingsEnabled: true,
                compassEnabled: true,
                markers: _buildMarkers(state.lights),
                onMapCreated: (controller) => _onMapCreated(controller, state.lights),
                onCameraMove: (cameraPosition) => _onCameraMove(
                  cameraPosition,
                  state.lights,
                ),
              ),
              ..._buildCounters(state.lights),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
