import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/remote_database_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/data/sentence_repository.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final SentenceRepository _repository;
  final RemoteDatabaseService _databaseService;
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
    final complexity =
        locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

    execute(
      () => _repository.getSentence(complexity: complexity).then((sentence) {
        _databaseService.saveSpeakOutLoud(sentence);
        return sentence;
      }),
    );
  }
}
