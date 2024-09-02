import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/quiz/data/i_quiz_remote_data_source.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';

class QuizRepository {
  final IQuizRemoteDataSource _remoteDataSource;

  QuizRepository(this._remoteDataSource);

  Future<QuizModel> getQuiz({
    Complexity? complexity,
  }) async {
    return _remoteDataSource.generateQuiz(
      complexity: complexity ?? Complexity.easy,
    );
  }
}
