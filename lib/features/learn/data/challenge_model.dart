import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';

class ChallengeModel {
  final String? id;
  final Complexity complexity;
  final DateTime createdOn;
  final DateTime expiresOn;
  final List<Exercise>? questions;

  ChallengeModel({
    required this.complexity,
    required this.createdOn,
    required this.id,
    required this.expiresOn,
    this.questions,
  });

  ChallengeModel copyWith({
    String? id,
    Complexity? complexity,
    DateTime? createdOn,
    DateTime? expiresOn,
    List<Exercise>? questions,
  }) {
    return ChallengeModel(
      id: id ?? this.id,
      complexity: complexity ?? this.complexity,
      createdOn: createdOn ?? this.createdOn,
      expiresOn: expiresOn ?? this.expiresOn,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'complexity': complexity.name,
      'createdOn': createdOn.toUtc().toIso8601String(),
      'expiresOn': expiresOn.toUtc().toIso8601String(),
      'questions': questions?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory ChallengeModel.fromMap(Map<String, dynamic> map) {
    return ChallengeModel(
      id: map['id'],
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

  factory ChallengeModel.fromMapAndId(String id, Map<String, dynamic> map) {
    return ChallengeModel(
      id: id,
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
    return 'ChallengeModel(id: $id, complexity: $complexity, createdOn: $createdOn, expiresOn: $expiresOn, questions: $questions)';
  }

  @override
  bool operator ==(covariant ChallengeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.complexity == complexity &&
        other.createdOn == createdOn &&
        other.expiresOn == expiresOn &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        complexity.hashCode ^
        createdOn.hashCode ^
        expiresOn.hashCode ^
        questions.hashCode;
  }
}
