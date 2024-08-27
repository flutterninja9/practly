import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/env/env.dart';
import 'package:practly/di/di.dart';
import 'package:practly/firebase_options.dart';
import 'package:practly/core/services/config_service.dart';

Future<void> setupCore() async {
  await _initializeFirebase();
  await _loadConfigs();
  _setupGemini();
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> _loadConfigs() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  locator.registerSingleton<ConfigService>(
    ConfigService(remoteConfig, Env.current),
  );

  final config = await locator.get<ConfigService>().getConfig();
  locator.registerSingleton<Config>(config);
}

void _setupGemini() {
  final gemini = GoogleGemini(
    apiKey: locator.get<Config>().geminiKey,
  );

  locator.registerSingleton<GoogleGemini>(gemini);
}
