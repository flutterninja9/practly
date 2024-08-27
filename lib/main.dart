import 'package:flutter/material.dart';
import 'package:practly/app/speak_ease_app.dart';
import 'package:practly/service_locator/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDeps();

  runApp(const SpeakEaseApp());
}
