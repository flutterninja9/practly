import 'package:practly/di/di.dart';
import 'package:practly/features/learn/buisness_logic/word_of_the_day_notifier.dart';
import 'package:practly/features/learn/data/gemini_word_remote_data_source.dart';
import 'package:practly/features/learn/data/i_word_remote_data_source.dart';
import 'package:practly/features/learn/data/word_repository.dart';

void setupWordOfTheDay() {
  locator.registerSingleton<IWordRemoteDataSource>(
    GeminiWordRemoteDataSource(locator.get()),
  );

  locator.registerSingleton<WordRepository>(WordRepository(locator.get()));

  locator.registerFactory<WordOfTheDayNotifier>(
    () => WordOfTheDayNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );
}
