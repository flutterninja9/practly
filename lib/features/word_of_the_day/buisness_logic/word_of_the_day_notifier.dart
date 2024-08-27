import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';
import 'package:practly/features/word_of_the_day/data/word_repository.dart';

class WordOfTheDayNotifier extends AsyncNotifier<WordOfTheDayModel> {
  final WordRepository _repository;

  WordOfTheDayNotifier(this._repository);


  void generateWord() {
    execute(
      () => _repository
          .getWord(complexity: complexity),
    );
  }
}
