import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/features/quiz/data/i_quiz_remote_data_source.dart';

class GeminiQuizDataSource extends IQuizRemoteDataSource {
  final GoogleGemini _gemini;

  GeminiQuizDataSource(this._gemini);

  @override
  Future<QuizModel> generateQuiz({
    Complexity complexity = Complexity.easy,
  }) async {
    final res = await _gemini.generateFromText(prompt(complexity));
    return QuizModel.fromJson(res.text);
  }
}
