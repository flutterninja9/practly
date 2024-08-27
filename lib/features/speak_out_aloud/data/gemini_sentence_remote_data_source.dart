import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class GeminiSentenceRemoteDataSource extends ISentenceRemoteDataSource {
  final GoogleGemini _gemini;

  GeminiSentenceRemoteDataSource(this._gemini);

  @override
  Future<SpeakOutAloudModel> generateSentence({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    final res = await _gemini.generateFromText(prompt(complexity));
    return SpeakOutAloudModel.fromJson(res.text);
  }
}
