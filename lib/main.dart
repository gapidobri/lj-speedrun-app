import 'package:flutter/material.dart';
import 'package:lj_speedrun/services/chopper.service.dart';

import 'app.dart';

void main() {
  ChopperService.init();

  runApp(const App());
}
