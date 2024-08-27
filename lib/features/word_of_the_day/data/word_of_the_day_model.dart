import 'dart:convert';

class WordOfTheDayModel {
  final String word;
  final String definition;
  final String example;
  final String usage;

  const WordOfTheDayModel({
    required this.word,
    required this.definition,
    required this.example,
    required this.usage,
  });

  factory WordOfTheDayModel.fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);

    return WordOfTheDayModel(
      word: data['word'] ?? '',
      definition: data['definition'] ?? '',
      example: data['example'] ?? '',
      usage: data['usage'] ?? '',
    );
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
