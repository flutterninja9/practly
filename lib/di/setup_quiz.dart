import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/business_logic/quiz_notifier.dart';
import 'package:practly/features/quiz/data/quiz_remote_data_source.dart';
import 'package:practly/features/quiz/data/i_quiz_local_data_source.dart';
import 'package:practly/features/quiz/data/i_quiz_remote_data_source.dart';
import 'package:practly/features/quiz/data/quiz_local_data_source.dart';
import 'package:practly/features/quiz/data/quiz_repository.dart';

void setupQuiz() {
  locator.registerSingleton<IQuizLocalDataSource>(
    QuizLocalDataSource(locator.get()),
  );

  locator.registerSingleton<IQuizRemoteDataSource>(
    QuizRemoteDataSource(
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );

  locator.registerSingleton<QuizRepository>(QuizRepository(locator.get()));

  locator.registerFactory<QuizNotifier>(() => QuizNotifier(
        locator.get(),
        locator.get(),
        locator.get(),
        locator.get(),
      ));
}
