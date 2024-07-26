import 'package:get_it/get_it.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:practly/services/gemini_service.dart';

final locator = GetIt.I;

Future<void> initializeDeps() async {
  setupGemini();
  setupGenerationService();
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
