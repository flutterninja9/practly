import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/data/gemini_sentence_remote_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';

void setupSpeakOutAloud() {
  locator.registerSingleton<ISentenceRemoteDataSource>(
    GeminiSentenceRemoteDataSource(locator.get()),
  );

  locator
      .registerSingleton<SentenceRepository>(SentenceRepository(locator.get()));
}
