import 'package:drift/drift.dart';
import 'package:practly/core/database/app_database.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';
import 'package:practly/features/learn/data/i_learn_local_data_source.dart';

class LearnLocalDataSource implements ILearnLocalDataSource {
  final AppDatabase _database;

  LearnLocalDataSource(this._database);

  @override
  Future<WordOfTheDayModel?> getWord(Complexity complexity) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final cachedWord = await (_database.select(_database.wordsTable)
          ..where((tbl) => tbl.createdAt.isBiggerOrEqualValue(startOfDay))
          ..where((tbl) => tbl.complexity.equals(complexity.name)))
        .getSingleOrNull();

    if (cachedWord != null) {
      return WordOfTheDayModel(
        word: cachedWord.word,
        definition: cachedWord.definition,
        example: cachedWord.example,
        usage: cachedWord.usage,
        complexity: Complexity.fromString(cachedWord.complexity),
      );
    }

    return null;
  }

  @override
  Future<void> setWord(WordOfTheDayModel word) async {
    await _database.into(_database.wordsTable).insert(
          WordsTableCompanion.insert(
            word: word.word,
            definition: word.definition,
            example: word.example,
            usage: word.usage,
            complexity: word.complexity.name,
          ),
        );
  }
}
