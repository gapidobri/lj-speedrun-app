import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lj_speedrun/models/traffic_light.model.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({Key? key, required this.light}) : super(key: key);

  final TrafficLight light;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? timer;
  int countdown = 0;
  bool green = false;

  @override
  void initState() {
    updateTimer();

    timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (Timer t) => updateTimer(),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateTimer() {
    final current = DateTime.now().toIso8601String().split('T').last.split('.').first;

    final currentSeconds = _calculateSeconds(current);
    final captureSeconds = _calculateSeconds(widget.light.captureTime) + widget.light.seconds;

    setState(() {
      countdown = (captureSeconds - currentSeconds) % widget.light.interval;
      green = countdown > widget.light.interval - widget.light.greenLength;
    });
  }

  int _calculateSeconds(String time) {
    final parts = time.split(':');
    int seconds = 0;
    seconds += int.parse(parts[0]) * 60 * 60;
    seconds += int.parse(parts[1]) * 60;
    seconds += int.parse(parts[2]);
    return seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: green ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          countdown.toString(),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
