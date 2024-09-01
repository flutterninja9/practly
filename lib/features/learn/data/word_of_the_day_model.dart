import 'dart:convert';

import 'package:practly/core/enums/enums.dart';

class WordOfTheDayModel {
  final String word;
  final String definition;
  final String example;
  final String usage;
  final WordComplexity complexity;

  const WordOfTheDayModel({
    required this.word,
    required this.definition,
    required this.example,
    required this.usage,
    required this.complexity,
  });

  factory WordOfTheDayModel.fromJson(String source, WordComplexity? complexity) {
    final Map<String, dynamic> data = json.decode(source);

    return WordOfTheDayModel(
      word: data['word'] ?? '',
      definition: data['definition'] ?? '',
      example: data['example'] ?? '',
      complexity: data['complexity'] ?? complexity,
      usage: data['usage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'definition': definition,
      'example': example,
      'usage': usage,
      'complexity': complexity.name,
    };
  }

  @override
  String toString() {
    return 'WordOfTheDayModel(word: $word, definition: $definition, example: $example, usage: $usage)';
  }

  @override
  bool operator ==(covariant WordOfTheDayModel other) {
    if (identical(this, other)) return true;

    return other.word == word &&
        other.definition == definition &&
        other.example == example &&
        other.usage == usage;
  }

  @override
  int get hashCode {
    return word.hashCode ^
        definition.hashCode ^
        example.hashCode ^
        usage.hashCode;
  }
}
