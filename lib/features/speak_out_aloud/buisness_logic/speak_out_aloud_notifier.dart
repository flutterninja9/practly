import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/services/speech_to_text_service.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final SentenceRepository _repository;
  final SpeechToTextService stt;

  bool _enableSpeechButton = true;

  bool get enableSpeechButton => _enableSpeechButton;

  set enableSpeechButton(bool value) {
    _enableSpeechButton = value;

    notifyListeners();
  }

  SpeakOutAloudNotifier(this._repository, this.stt);

  void generateSentence() {
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
