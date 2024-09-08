import 'package:practly/core/models/quiz/quiz_model.dart';

abstract class IQuizLocalDataSource {
  Future<QuizModel?> getQuiz();

  Future<void> setQuiz(QuizModel? quiz);
}
