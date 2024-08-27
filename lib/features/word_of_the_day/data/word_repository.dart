import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/word_of_the_day/data/i_word_remote_data_source.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';

class WordRepository {
  final IWordRemoteDataSource _remoteDataSource;

  WordRepository(this._remoteDataSource);

  Future<WordOfTheDayModel> getWord({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    return _remoteDataSource.generateWordOfTheDay(complexity: complexity);
  }
}
