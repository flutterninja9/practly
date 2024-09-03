import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:practly/core/database/tables/sentences_table.dart';
import 'package:practly/core/database/tables/word_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [WordsTable, SentencesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'app_database');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.createTable(sentencesTable);
          }
        },
      );
}
