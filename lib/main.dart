import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:practly/app/practly_app.dart';
import 'package:practly/config/config.dart';
import 'package:practly/service_locator/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDeps();
  log(locator.get<Config>().geminiKey);

  runApp(const PractlyApp());
}
