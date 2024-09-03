import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

abstract class ISentenceLocalDataSource {
  Future<SpeakOutAloudModel?> getSentence();

  Future<void> setSentence(SpeakOutAloudModel? model);
}
