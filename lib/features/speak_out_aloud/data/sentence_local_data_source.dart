import 'package:drift/drift.dart';
import 'package:practly/core/database/app_database.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';
import 'package:practly/features/speak_out_aloud/data/i_sentence_local_data_source.dart';

class SentenceLocalDataSource implements ISentenceLocalDataSource {
  final AppDatabase _database;

  SentenceLocalDataSource(this._database);
  @override
  Future<SpeakOutAloudModel?> getSentence() async {
    final result = await (_database.select(_database.sentencesTable)
          ..where((s) => s.id.equals(1)))
        .getSingleOrNull();

    if (result != null) {
      return SpeakOutAloudModel(
        sentence: result.sentence,
        explanation: result.explanation,
        tip: result.tip,
        complexity: Complexity.fromString(result.complexity),
      );
    }

    return null;
  }

  @override
  Future<void> setSentence(SpeakOutAloudModel? model) async {
    if (model == null) {
      await _database.customStatement('DELETE FROM sentences_table WHERE id=1');
    } else {
      await _database.into(_database.sentencesTable).insert(
            SentencesTableCompanion.insert(
              id: const Value(1),
              sentence: model.sentence,
              explanation: model.explanation,
              tip: model.tip,
              complexity: model.complexity.name,
            ),
          );
    }
  }
}
