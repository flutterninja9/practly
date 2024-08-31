import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:practly/core/config/config.dart';
import 'package:practly/core/navigation/app_router.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/core/services/score_logic.dart';
import 'package:practly/core/services/speech_to_text_service.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/firebase_options/firebase_options.dart';
import 'package:practly/core/services/config_service.dart';
import 'package:practly/firebase_options/firebase_options.dev.dart';
import 'package:practly/flavors.dart';
import 'package:speech_to_text/speech_to_text.dart';

Future<void> setupCore() async {
  await _initializeFirebase();
  await _loadConfigs();
  _setupDatabaseService();
  _initializeFirebaseAuth();
  _setupGemini();
  _setupScoreLogic();
  _setupSpeechToTextService();
  _setupTextToSpeechService();
  _setupRouter();
  _setupAdService();
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(options: _getFirebaseConfig());
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
}

void _initializeFirebaseAuth() {
  final notifier = FirebaseAuthNotifier(locator.get());

  locator.registerSingleton<FirebaseAuthNotifier>(notifier);
}

FirebaseOptions _getFirebaseConfig() {
  return switch (F.appFlavor) {
    Flavor.prod => ProdFirebaseOptions.currentPlatform,
    Flavor.dev => DevFirebaseOptions.currentPlatform,
    null => throw UnimplementedError(),
  };
}

Future<void> _loadConfigs() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  locator.registerSingleton<ConfigService>(
    ConfigService(remoteConfig, F.name),
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

void _setupSpeechToTextService() {
  locator.registerSingleton<TextToSpeechService>(
      TextToSpeechService(FlutterTts()));
}

void _setupTextToSpeechService() {
  locator.registerFactory<SpeechToText>(() => SpeechToText());
  locator.registerFactory<SpeechToTextService>(
      () => SpeechToTextService(locator.get()));
}

void _setupScoreLogic() {
  locator.registerSingleton<ScoreLogic>(ScoreLogic());
}

void _setupRouter() {
  final router = AppRouter();

  locator.registerSingleton<GoRouter>(router.getRouter);
}

void _setupDatabaseService() {
  locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  locator.registerSingleton<DatabaseService>(DatabaseService(
    locator.get(),
    locator.get(),
    locator.get(),
  ));
}

void _setupAdService() {
  locator.registerSingleton<MobileAds>(MobileAds.instance);
  locator.registerSingleton<AdService>(AdService(locator.get(), locator.get()));
  locator.get<AdService>().initializeAds();
}
