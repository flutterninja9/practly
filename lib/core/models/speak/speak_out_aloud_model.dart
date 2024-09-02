import 'dart:convert';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';

class SpeakOutAloudModel implements Exercise {
  final String sentence;
  final String explanation;
  final String tip;
  final Complexity complexity;

  SpeakOutAloudModel({
    required this.sentence,
    required this.explanation,
    required this.complexity,
    required this.tip,
  });

  factory SpeakOutAloudModel.fromJson(
    String source,
    Complexity? complexity,
  ) {
    final Map<String, dynamic> data = json.decode(source);

    return SpeakOutAloudModel.fromMap(data, complexity);
  }

  factory SpeakOutAloudModel.fromMap(
    Map<String, dynamic> map,
    Complexity? complexity,
  ) {
    return SpeakOutAloudModel(
      sentence: map['sentence'] ?? '',
      explanation: map['explanation'] ?? '',
      complexity: map['complexity'] ?? complexity,
      tip: map['tip'] ?? '',
    );
  }

  @override
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

  @override
  String get type => "sentence";
}
