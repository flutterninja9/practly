import 'package:flutter/material.dart';
import 'package:speakease/app/practly_app.dart';
import 'package:speakease/service_locator/service_locator.dart';

Future<void> main() async {
  await initializeDeps();

  runApp(const PractlyApp());
}
