import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/firebase_options.dart';
import 'package:practly/services/gemini_service.dart';

final locator = GetIt.I;

Future<void> initializeDeps() async {
  await setupFirebase();
  setupGemini();
  setupGenerationService();
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void setupGemini() {
  final gemini = GoogleGemini(
    apiKey: const String.fromEnvironment("GEMINI_KEY"),
  );

  locator.registerSingleton<GoogleGemini>(gemini);
}

void setupGenerationService() {
  locator
      .registerSingleton<GenerationService>(GenerationService(locator.get()));
}
