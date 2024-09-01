import 'package:flutter/foundation.dart';
import 'package:practly/core/services/score_logic.dart';
import 'package:practly/core/services/speech_to_text_service.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

class SpeakExcerciseViewmodel with ChangeNotifier {
  final SpeakOutAloudModel model;
  final ScoreLogic scoreLogic;
  final TextToSpeechService tts;
  final SpeechToTextService stt;

  SpeakExcerciseViewmodel(
    this.model,
    this.scoreLogic,
    this.stt,
    this.tts,
  );

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

  Future<void> listen() async {
    enableSpeechButton = false;

    await stt.startListening(
      onDoneSpeaking: onDoneSpeaking,
      onInitializationError: onError,
    );
  }

  void onDoneSpeaking(words) {
    enableSpeechButton = true;
    score = scoreLogic.calculateScore(model.sentence, words);
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
