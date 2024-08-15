import 'package:flutter/material.dart';
import 'package:practly/app/practly_app.dart';
import 'package:practly/service_locator/service_locator.dart';

Future<void> main() async {
  await initializeDeps();

  runApp(const PractlyApp());
}
