import 'dart:convert';

class SpeakOutAloudModel {
  final String sentence;
  final String explanation;
  final String tip;

  SpeakOutAloudModel({
    required this.sentence,
    required this.explanation,
    required this.tip,
  });

  factory SpeakOutAloudModel.fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);

    return SpeakOutAloudModel(
      sentence: data['sentence'] ?? '',
      explanation: data['explanation'] ?? '',
      tip: data['tip'] ?? '',
    );
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
