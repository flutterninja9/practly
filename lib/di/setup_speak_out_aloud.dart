import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/buisness_logic/speak_out_aloud_notifier.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_remote_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_local_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_local_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';

void setupSpeakOutAloud() {
  locator.registerSingleton<ISentenceRemoteDataSource>(
    SentenceRemoteDataSource(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerSingleton<ISentenceLocalDataSource>(
      SentenceLocalDataSource(locator.get()));

  locator
      .registerSingleton<SentenceRepository>(SentenceRepository(locator.get()));

  locator.registerFactory<SpeakOutAloudNotifier>(
    () => SpeakOutAloudNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );
}
