import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts _tts;

  TextToSpeechService(this._tts);

  Future<void> speak(String words) async {
    await _tts.speak(words);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
