import 'dart:convert';

import 'package:practly/core/enums/enums.dart';

class SpeakOutAloudModel {
  final String sentence;
  final String explanation;
  final String tip;
  final WordComplexity complexity;

  SpeakOutAloudModel({
    required this.sentence,
    required this.explanation,
    required this.complexity,
    required this.tip,
  });

  factory SpeakOutAloudModel.fromJson(
      String source, WordComplexity? complexity) {
    final Map<String, dynamic> data = json.decode(source);

    return SpeakOutAloudModel(
      sentence: data['sentence'] ?? '',
      explanation: data['explanation'] ?? '',
      complexity: data['complexity'] ?? complexity,
      tip: data['tip'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentence': sentence,
      'explanation': explanation,
      'tip': tip,
      'complexity': complexity.name,
    };
  }

  @override
  String toString() =>
      'SpeakOutAloudModel(sentence: $sentence, explanation: $explanation, tip: $tip)';

  @override
  bool operator ==(covariant SpeakOutAloudModel other) {
    if (identical(this, other)) return true;

    return other.sentence == sentence &&
        other.explanation == explanation &&
        other.tip == tip;
  }

  @override
  int get hashCode => sentence.hashCode ^ explanation.hashCode ^ tip.hashCode;
}
