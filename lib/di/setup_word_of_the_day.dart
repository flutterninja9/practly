import 'package:practly/di/di.dart';
import 'package:practly/features/word_of_the_day/data/gemini_word_remote_data_source.dart';
import 'package:practly/features/word_of_the_day/data/i_word_remote_data_source.dart';

void setupWordOfTheDay() {
  locator.registerSingleton<IWordRemoteDataSource>(
    GeminiWordRemoteDataSource(locator.get()),
  );
}
