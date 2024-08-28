import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/services/score_logic.dart';
import 'package:practly/core/services/speech_to_text_service.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final SentenceRepository _repository;
  final ScoreLogic _scoreLogic;
  final SpeechToTextService stt;

  int _score = 0;

  int get score => _score;

  set score(int value) {
    _score = value;

    notifyListeners();
  }

  bool _enableSpeechButton = true;

  bool get enableSpeechButton => _enableSpeechButton;

  set enableSpeechButton(bool value) {
    _enableSpeechButton = value;

    notifyListeners();
  }

  SpeakOutAloudNotifier(this._repository, this.stt, this._scoreLogic);

  void generateSentence() {
    score = 0;
    execute(
      () => _repository.getSentence(complexity: complexity),
    );
  }

  Future<void> listen() async {
    enableSpeechButton = false;

    await stt.startListening(
      onDoneSpeaking: onDoneSpeaking,
      onInitializationError: onError,
    );
  }

  void onDoneSpeaking(words) {
    enableSpeechButton = true;
    state.mapOrNull(
      data: (value) {
        score = _scoreLogic.calculateScore(value.value.sentence, words);
      },
    );
  }

  void onError() {
    stt.stopListening();
    enableSpeechButton = true;
  }

  @override
  void dispose() {
    stt.dispose();
    super.dispose();
  }
}
