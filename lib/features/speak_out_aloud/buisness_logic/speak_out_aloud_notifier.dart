import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/remote_database_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_local_data_source.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_remote_data_source.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

class SpeakOutAloudNotifier extends AsyncNotifier<SpeakOutAloudModel> {
  final ISentenceRemoteDataSource _remoteDataSource;
  final ISentenceLocalDataSource _localDataSource;
  final RemoteDatabaseService _databaseService;
  final AdService _adService;

  SpeakOutAloudNotifier(
    this._remoteDataSource,
    this._databaseService,
    this._localDataSource,
    this._adService,
  ) : super(
          _databaseService,
          _adService,
        );

  Future<void> clearOlderResults() async {
    _localDataSource.setSentence(null);
  }

  Future<void> generateSentence() async {
    final cachedData = await _localDataSource.getSentence();

    if (cachedData != null) {
      execute(() async => cachedData, isAIGeneration: false);
    } else {
      final complexity =
          locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

      execute(
        () => _remoteDataSource
            .generateSentence(complexity: complexity)
            .then((sentence) {
          Future.wait([
            _localDataSource.setSentence(sentence),
            _databaseService.saveSpeakOutLoud(sentence),
          ]);

          return sentence;
        }),
      );
    }
  }
}
