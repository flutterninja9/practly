import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

abstract class Exercise {
  final String type;

  Exercise(this.type);

  Map<String, dynamic> toMap();

  static Exercise fromMap(
    Map<String, dynamic> map,
  ) {
    switch (map['type']) {
      case 'quiz':
        return QuizModel.fromMap(map);
      case 'sentence':
        return SpeakOutAloudModel.fromMap(map);
      default:
        throw Exception('Unknown type ${map["type"]}');
    }
  }
}
