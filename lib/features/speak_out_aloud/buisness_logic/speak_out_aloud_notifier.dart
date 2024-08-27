import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final SentenceRepository _repository;

  SpeakOutAloudNotifier(this._repository);

  void generateSentence() {
    execute(
      () => _repository.getSentence(complexity: complexity),
    );
  }
}
