import 'dart:convert';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';

class SpeakOutAloudModel implements Exercise {
  final String? id;
  final String sentence;
  final String explanation;
  final String tip;
  final Complexity complexity;

  SpeakOutAloudModel({
    this.id,
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
      id: map['id'],
      sentence: map['sentence'] ?? '',
      explanation: map['explanation'] ?? '',
      complexity: map['complexity'] != null
          ? Complexity.fromString(map['complexity'])
          : Complexity.easy,
      tip: map['tip'] ?? '',
    );
  }

  factory SpeakOutAloudModel.fromFirestoreMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return SpeakOutAloudModel(
      id: id,
      sentence: map['sentence'] ?? '',
      explanation: map['explanation'] ?? '',
      complexity: map['complexity'] != null
          ? Complexity.fromString(map['complexity'])
          : Complexity.easy,
      tip: map['tip'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sentence': sentence,
      'explanation': explanation,
      'tip': tip,
      'complexity': complexity.name,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'SpeakOutAloudModel(id: $id, sentence: $sentence, explanation: $explanation, tip: $tip, complexity: $complexity)';
  }

  @override
  bool operator ==(covariant SpeakOutAloudModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sentence == sentence &&
        other.explanation == explanation &&
        other.tip == tip &&
        other.complexity == complexity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sentence.hashCode ^
        explanation.hashCode ^
        tip.hashCode ^
        complexity.hashCode;
  }

  @override
  String get type => "sentence";
}
