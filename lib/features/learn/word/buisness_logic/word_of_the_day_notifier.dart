import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/features/learn/data/word_of_the_day_model.dart';
import 'package:practly/features/learn/data/learn_repository.dart';

class WordOfTheDayNotifier extends AsyncNotifier<WordOfTheDayModel> {
  final LearnRepository _repository;
  final DatabaseService _databaseService;
  final AdService _adService;

  WordOfTheDayNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> generateWord() async {
    execute(
      () => _repository.getWord(complexity: complexity).then((word) {
        _databaseService.saveWordOfTheDay(word);
        return word;
      }),
    );
  }
}
