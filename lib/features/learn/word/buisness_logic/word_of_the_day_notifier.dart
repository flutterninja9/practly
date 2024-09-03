import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/remote_database_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';
import 'package:practly/features/learn/data/i_learn_local_data_source.dart';
import 'package:practly/features/learn/data/i_learn_remote_data_source.dart';

class WordOfTheDayNotifier extends AsyncNotifier<WordOfTheDayModel> {
  final ILearnRemoteDataSource _remoteDataSource;
  final ILearnLocalDataSource _localDataSource;
  final RemoteDatabaseService _databaseService;
  final AdService _adService;

  WordOfTheDayNotifier(
    this._remoteDataSource,
    this._databaseService,
    this._localDataSource,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> generateWord() async {
    final complexity =
        locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

    final cachedWord =
        await _localDataSource.getWord(complexity ?? Complexity.easy);

    if (cachedWord != null) {
      execute(() async => cachedWord, isAIGeneration: false);
    } else {
      execute(
        () => _remoteDataSource
            .generateWordOfTheDay(complexity: complexity)
            .then((word) {
          Future.wait([
            _localDataSource.setWord(word),
            _databaseService.saveWordOfTheDay(word),
          ]);
          
          return word;
        }),
      );
    }
  }
}
