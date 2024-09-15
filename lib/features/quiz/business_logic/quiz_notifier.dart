import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/data/i_quiz_local_data_source.dart';
import 'package:practly/features/quiz/data/i_quiz_remote_data_source.dart';

class QuizNotifier extends AsyncNotifier<QuizModel> {
  final IQuizRemoteDataSource _remoteDataSource;
  final IQuizLocalDataSource _localDataSource;
  final UserService _databaseService;
  final AdService _adService;

  QuizNotifier(
    this._remoteDataSource,
    this._localDataSource,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> clearOlderResults() async {
    _localDataSource.setQuiz(null);
  }

  Future<void> generateQuiz() async {
    final cachedData = await _localDataSource.getQuiz();

    if (cachedData != null) {
      execute(() async => cachedData, isAIGeneration: false);
    } else {
      final complexity =
          locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

      execute(() =>
          _remoteDataSource.generateQuiz(complexity: complexity).then((quiz) {
            _localDataSource.setQuiz(quiz);
            return quiz;
          }));
    }
  }
}
