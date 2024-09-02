import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/data/quiz_repository.dart';

class QuizNotifier extends AsyncNotifier<QuizModel> {
  final QuizRepository _repository;
  final DatabaseService _databaseService;
  final AdService _adService;

  QuizNotifier(this._repository, this._databaseService, this._adService)
      : super(_databaseService, _adService);

  void generateQuiz() {
    final complexity = locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

    execute(
      () => _repository.getQuiz(complexity: complexity),
    );
  }
}
