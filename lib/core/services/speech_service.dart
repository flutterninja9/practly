import 'package:flutter_tts/flutter_tts.dart';

class SpeechService {
  final FlutterTts _tts;

  SpeechService(this._tts);

  Future<void> speak(String words) async {
    await _tts.speak(words);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
