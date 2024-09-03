import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';

abstract class ILearnLocalDataSource {
  Future<WordOfTheDayModel?> getWord(Complexity complexity);

  Future<void> setWord(WordOfTheDayModel model);
}
