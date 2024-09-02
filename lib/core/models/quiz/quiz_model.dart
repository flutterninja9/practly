import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:practly/core/models/excercise.dart';

class QuizModel implements Exercise {
  final String sentence;
  final Map<String, String> options;
  final String correctAnswer;

  const QuizModel({
    required this.sentence,
    required this.options,
    required this.correctAnswer,
  });

  factory QuizModel.fromJson(String source) {
    final Map<String, dynamic> data = jsonDecode(source);

    return QuizModel.fromMap(data);
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      sentence: map['sentence'] ?? '',
      options: Map<String, String>.from(map['options'] ?? {}),
      correctAnswer: map['correct_answer'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentence': sentence,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }

  @override
  String toString() {
    return 'QuizModel(sentence: $sentence, options: $options, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.sentence == sentence &&
        mapEquals(other.options, options) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return sentence.hashCode ^ options.hashCode ^ correctAnswer.hashCode;
  }

  @override
  String get type => "quiz";
}
