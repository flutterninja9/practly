import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practly/core/enums/enums.dart';

import 'package:practly/core/models/excercise.dart';

class QuizModel implements Exercise {
  final String? id;
  final String sentence;
  final Map<String, String> options;
  final String correctAnswer;
  final Complexity complexity;

  const QuizModel({
    this.id,
    required this.sentence,
    required this.options,
    required this.complexity,
    required this.correctAnswer,
  });

  factory QuizModel.fromJson(String source) {
    final Map<String, dynamic> data = jsonDecode(source);

    return QuizModel.fromMap(data);
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id'],
      sentence: map['sentence'] ?? '',
      complexity: Complexity.fromString(map['complexity']),
      options: Map<String, String>.from(map['options'] ?? {}),
      correctAnswer: map['correct_answer'] ?? '',
    );
  }

  factory QuizModel.fromFirestoreMap(String id, Map<String, dynamic> map) {
    return QuizModel(
      id: id,
      complexity: Complexity.fromString(map['complexity']),
      sentence: map['sentence'] ?? '',
      options: Map<String, String>.from(map['options'] ?? {}),
      correctAnswer: map['correct_answer'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sentence': sentence,
      'options': options,
      'complexity': complexity.name,
      'correct_answer': correctAnswer,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'QuizModel(id: $id, sentence: $sentence, options: $options, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sentence == sentence &&
        mapEquals(other.options, options) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sentence.hashCode ^
        options.hashCode ^
        correctAnswer.hashCode;
  }

  @override
  String get type => "quiz";
}
