import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/config/config.dart';
import 'package:practly/config/env.dart';
import 'package:practly/firebase_options.dart';
import 'package:practly/services/config_service.dart';
import 'package:practly/services/gemini_service.dart';

final locator = GetIt.I;

Future<void> initializeDeps() async {
  await setupFirebase();
  await loadConfigs();
  setupGemini();
  setupGenerationService();
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> loadConfigs() async {
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

void setupGemini() {
  final gemini = GoogleGemini(
    apiKey: locator.get<Config>().geminiKey,
  );

  locator.registerSingleton<GoogleGemini>(gemini);
}

void setupGenerationService() {
  locator
      .registerSingleton<GenerationService>(GenerationService(locator.get()));
}
