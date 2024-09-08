import 'dart:convert';

import 'package:drift/drift.dart';

class QuizTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sentence => text().named("sentence")();
  TextColumn get options => text().map(const MapConverter()).named("options")();
  TextColumn get correctAnswer => text().named("correct_answer")();
  TextColumn get complexity => text().named('complexity')();
  TextColumn get type => text().named("type")();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Custom type converter to handle Map<String, String> serialization
class MapConverter extends TypeConverter<Map<String, String>, String> {
  const MapConverter();

  @override
  Map<String, String> fromSql(String fromDb) {
    return Map<String, String>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(Map<String, String> value) {
    return jsonEncode(value);
  }
}
