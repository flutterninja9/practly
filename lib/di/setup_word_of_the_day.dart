import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_challenge/buisness_logic/challenge_notifier.dart';
import 'package:practly/features/learn/daily_challenge/buisness_logic/daily_challenge_notifier.dart';
import 'package:practly/features/learn/daily_dialogs/buisness_logic/daily_dialogs_notifier.dart';
import 'package:practly/features/learn/data/i_learn_local_data_source.dart';
import 'package:practly/features/learn/data/learn_local_data_source.dart';
import 'package:practly/features/learn/exercise/buisness_logic/excercise_notifier.dart';
import 'package:practly/features/learn/word/buisness_logic/word_of_the_day_notifier.dart';
import 'package:practly/features/learn/data/learn_remote_data_source.dart';
import 'package:practly/features/learn/data/i_learn_remote_data_source.dart';
import 'package:practly/features/learn/data/learn_repository.dart';

void setupLearn() {
  locator.registerSingleton<ILearnRemoteDataSource>(
    LearnRemoteDataSourceImpl(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerSingleton<ILearnLocalDataSource>(
    LearnLocalDataSource(locator.get()),
  );

  locator.registerSingleton<LearnRepository>(LearnRepository(locator.get()));

  locator.registerFactory<WordOfTheDayNotifier>(
    () => WordOfTheDayNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerFactory<DailyDialogsNotifier>(
    () => DailyDialogsNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerFactory<ExerciseNotifier>(
    () => ExerciseNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerFactory<DailyChallengeNotifier>(
    () => DailyChallengeNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerFactory<ChallengeNotifier>(
    () => ChallengeNotifier(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );
}
