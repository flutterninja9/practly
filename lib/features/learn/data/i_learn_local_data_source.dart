import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';

abstract class ILearnLocalDataSource {
  ILearnLocalDataSource(Object object, Object object2);

  Future<WordOfTheDayModel?> getWord(Complexity complexity);

  Future<void> setWord(WordOfTheDayModel model);
}
