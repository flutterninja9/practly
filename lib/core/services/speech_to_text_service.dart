import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _service;

  final StreamController<String> _streamController =
      StreamController.broadcast();

  Stream<String> get spokenWords => _streamController.stream;

  bool get listening => _service.isListening;

  SpeechToTextService(this._service);

  Future<bool> initialize({Function()? onError}) async {
    return _service.initialize(
      onError: (_) async {
        await onError?.call();
      },
    );
  }

  Future<void> startListening({
    Function(String)? onDoneSpeaking,
    Function()? onInitializationError,
  }) async {
    if (listening) {
      await stopListening();
    }

    final ok = await initialize(onError: onInitializationError);
    if (!ok) {
      await onInitializationError?.call();
      return;
    }

    _service.listen(onResult: (r) async {
      _streamController.add(r.recognizedWords);
      
      if (r.finalResult) {
        await onDoneSpeaking?.call(r.recognizedWords);
      }
    });
  }

  Future<void> stopListening() async {
    await _service.stop();
  }

  Future<void> dispose() async {
    _streamController.close();
    await _service.cancel();
  }
}
