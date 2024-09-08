import 'package:drift/drift.dart';
import 'package:practly/core/database/app_database.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/features/quiz/data/i_quiz_local_data_source.dart';

class QuizLocalDataSource implements IQuizLocalDataSource {
  final AppDatabase _database;

  QuizLocalDataSource(this._database);

  @override
  Future<QuizModel?> getQuiz() async {
    final result = await (_database.select(_database.quizTable)
          ..where((s) => s.id.equals(1)))
        .getSingleOrNull();

    if (result != null) {
      return QuizModel(
        sentence: result.sentence,
        options: result.options,
        correctAnswer: result.correctAnswer,
        complexity: Complexity.fromString(result.complexity),
      );
    }

    return null;
  }

  @override
  Future<void> setQuiz(QuizModel? quiz) async {
    if (quiz == null) {
      await _database.customStatement('DELETE FROM quiz_table WHERE id=1');
    } else {
      await _database.into(_database.quizTable).insert(
            QuizTableCompanion.insert(
              id: const Value(1),
              sentence: quiz.sentence,
              options: quiz.options,
              correctAnswer: quiz.correctAnswer,
              complexity: quiz.complexity.name,
              type: quiz.type,
            ),
          );
    }
  }
}
