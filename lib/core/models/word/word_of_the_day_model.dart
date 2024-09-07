import 'dart:convert';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/used_content_model.dart';

class WordOfTheDayModel {
  final String? id;
  final String word;
  final String definition;
  final String example;
  final String usage;
  final Complexity complexity;

  const WordOfTheDayModel({
    this.id,
    required this.word,
    required this.definition,
    required this.example,
    required this.usage,
    required this.complexity,
  });

  factory WordOfTheDayModel.fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);

    return WordOfTheDayModel(
      id: data['id'],
      word: data['word'] ?? '',
      definition: data['definition'] ?? '',
      example: data['example'] ?? '',
      complexity: Complexity.fromString(data['complexity']),
      usage: data['usage'] ?? '',
    );
  }

  factory WordOfTheDayModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return WordOfTheDayModel(
      id: id,
      word: map['word'] ?? '',
      definition: map['definition'] ?? '',
      example: map['example'] ?? '',
      complexity: Complexity.fromString(map['complexity']),
      usage: map['usage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'word': word,
      'definition': definition,
      'example': example,
      'usage': usage,
      'complexity': complexity.name,
    };
  }

  UsedContentModel toUsedContent() {
    return UsedContentModel(
      usedContentId: id!,
      type: 'word',
      generation: word,
    );
  }

  @override
  String toString() {
    return 'WordOfTheDayModel(id: $id, word: $word, definition: $definition, example: $example, usage: $usage, complexity: $complexity)';
  }

  @override
  bool operator ==(covariant WordOfTheDayModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.word == word &&
        other.definition == definition &&
        other.example == example &&
        other.usage == usage &&
        other.complexity == complexity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        word.hashCode ^
        definition.hashCode ^
        example.hashCode ^
        usage.hashCode ^
        complexity.hashCode;
  }

  WordOfTheDayModel copyWith({
    String? id,
    String? word,
    String? definition,
    String? example,
    String? usage,
    Complexity? complexity,
  }) {
    return WordOfTheDayModel(
      id: id ?? this.id,
      word: word ?? this.word,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      usage: usage ?? this.usage,
      complexity: complexity ?? this.complexity,
    );
  }
}
