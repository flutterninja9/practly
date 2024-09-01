import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final SentenceRepository _repository;
  final DatabaseService _databaseService;
  final AdService _adService;

  SpeakOutAloudNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(
          _databaseService,
          _adService,
        );

  void generateSentence() {
    execute(
      () => _repository.getSentence(complexity: complexity).then((sentence) {
        _databaseService.saveSpeakOutLoud(sentence);
        return sentence;
      }),
    );
  }
}
