import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/data/gemini_quiz_data_source.dart';
import 'package:practly/features/quiz/data/i_quiz_remote_data_source.dart';

void setupQuiz() {
  locator.registerSingleton<IQuizRemoteDataSource>(
    GeminiQuizDataSource(locator.get()),
  );
}
