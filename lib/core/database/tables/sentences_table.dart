import 'package:drift/drift.dart';

class SentencesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sentence => text().named('sentence')();
  TextColumn get explanation => text().named('explanation')();
  TextColumn get tip => text().named('tip')();
  TextColumn get complexity => text().named('complexity')();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
