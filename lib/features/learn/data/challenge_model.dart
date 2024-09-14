import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';

class ChallengeModel {
  final Complexity complexity;
  final DateTime createdOn;
  final DateTime expiresOn;
  final List<Exercise>? questions;

  ChallengeModel({
    required this.complexity,
    required this.createdOn,
    required this.expiresOn,
    this.questions,
  });

  ChallengeModel copyWith({
    Complexity? complexity,
    DateTime? createdOn,
    DateTime? expiresOn,
    List<Exercise>? questions,
  }) {
    return ChallengeModel(
      complexity: complexity ?? this.complexity,
      createdOn: createdOn ?? this.createdOn,
      expiresOn: expiresOn ?? this.expiresOn,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'complexity': complexity.name,
      'createdOn': createdOn.toUtc().toIso8601String(),
      'expiresOn': expiresOn.toUtc().toIso8601String(),
      'questions': questions?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory ChallengeModel.fromMap(Map<String, dynamic> map) {
    return ChallengeModel(
      complexity: Complexity.fromString(map['complexity']),
      createdOn: DateTime.parse(map['createdOn']).toLocal(),
      expiresOn: DateTime.parse(map['expiresOn']).toLocal(),
      questions: map['questions'] != null
          ? List<Exercise>.from(
              (map['questions'] as List?)?.map<Exercise>(
                      (x) => Exercise.fromMap(x as Map<String, dynamic>)) ??
                  [],
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChallengeModel.fromJson(String source) =>
      ChallengeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChallengeModel(complexity: $complexity, createdOn: $createdOn, expiresOn: $expiresOn, questions: $questions)';
  }

  @override
  bool operator ==(covariant ChallengeModel other) {
    if (identical(this, other)) return true;

    return other.complexity == complexity &&
        other.createdOn == createdOn &&
        other.expiresOn == expiresOn &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return complexity.hashCode ^
        createdOn.hashCode ^
        expiresOn.hashCode ^
        questions.hashCode;
  }
}
