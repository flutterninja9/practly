import 'package:drift/drift.dart';

class WordsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().named('word')();
  TextColumn get definition => text().named('definition')();
  TextColumn get example => text().named('example')();
  TextColumn get usage => text().named('usage')();
  TextColumn get complexity => text().named('complexity')();
  DateTimeColumn get createdAt =>
      dateTime().nullable().clientDefault(() => DateTime.now())();
}
