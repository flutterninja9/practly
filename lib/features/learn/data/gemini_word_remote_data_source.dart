import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/learn/data/i_word_remote_data_source.dart';
import 'package:practly/features/learn/data/word_of_the_day_model.dart';

class GeminiWordRemoteDataSource extends IWordRemoteDataSource {
  final GoogleGemini _gemini;

  GeminiWordRemoteDataSource(this._gemini);

  @override
  Future<WordOfTheDayModel> generateWordOfTheDay({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    final res = await _gemini.generateFromText(prompt(complexity));
    return WordOfTheDayModel.fromJson(res.text, complexity);
  }
}
