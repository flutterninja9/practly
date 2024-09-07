import 'dart:convert';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/models/used_content_model.dart';

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

  factory SpeakOutAloudModel.fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);

    return SpeakOutAloudModel.fromMap(data);
  }

  factory SpeakOutAloudModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return SpeakOutAloudModel(
      id: map['id'],
      sentence: map['sentence'] ?? '',
      explanation: map['explanation'] ?? '',
      complexity: Complexity.fromString(map['complexity']),
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
      complexity: Complexity.fromString(map['complexity']),
      tip: map['tip'] ?? '',
    );
  }

  UsedContentModel toUsedContent() {
    return UsedContentModel(
      usedContentId: id!,
      type: type,
      generation: sentence,
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

  SpeakOutAloudModel copyWith({
    String? id,
    String? sentence,
    String? explanation,
    String? tip,
    Complexity? complexity,
  }) {
    return SpeakOutAloudModel(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      explanation: explanation ?? this.explanation,
      tip: tip ?? this.tip,
      complexity: complexity ?? this.complexity,
    );
  }
}
