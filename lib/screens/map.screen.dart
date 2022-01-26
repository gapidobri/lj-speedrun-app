import 'package:flutter/material.dart';
import 'package:lj_speedrun/widgets/map.widget.dart';
import 'package:lj_speedrun/widgets/panel.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        body: const SafeArea(child: MapWidget()),
        panel: const PanelWidget(),
        parallaxEnabled: true,
        parallaxOffset: 1.0,
        defaultPanelState: PanelState.CLOSED,
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.grey.shade300,
        boxShadow: const [],
      ),
    );
  }
}
