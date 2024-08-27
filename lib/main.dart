import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:practly/app/speak_ease_app.dart';
import 'package:practly/di/di.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await initializeDeps();
  FlutterNativeSplash.remove();

  runApp(const SpeakEaseApp());
}
