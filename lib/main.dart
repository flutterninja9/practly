import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:practly/app/speak_ease_app.dart';
import 'package:practly/di/di.dart';
import 'package:practly/flavors.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Running ${F.appFlavor?.name} flavor");
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await initializeDeps();
  _setupCrashlytics();
  FlutterNativeSplash.remove();

  runApp(const SpeakEaseApp());
}

void _setupCrashlytics() {
  FirebaseCrashlytics.instance.setCustomKey("env", F.name);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
