import 'dart:convert';

import 'package:practly/features/learn/data/challenge_model.dart';

class DailyChallengeModel {
  final String? id;
  final String challengeId;
  final bool completed;
  final DateTime? completedOn;
  final DateTime? attemptedOn;
  final ChallengeModel challenge;

  DailyChallengeModel({
    this.id,
    required this.challengeId,
    required this.completed,
    this.completedOn,
    this.attemptedOn,
    required this.challenge,
  });

  DailyChallengeModel copyWith({
    String? id,
    String? challengeId,
    bool? completed,
    DateTime? completedOn,
    DateTime? attemptedOn,
    ChallengeModel? challenge,
  }) {
    return DailyChallengeModel(
      id: id ?? this.id,
      challengeId: challengeId ?? this.challengeId,
      completed: completed ?? this.completed,
      completedOn: completedOn ?? this.completedOn,
      attemptedOn: attemptedOn ?? this.attemptedOn,
      challenge: challenge ?? this.challenge,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'challengeId': challengeId,
      'completed': completed,
      'completedOn': completedOn?.millisecondsSinceEpoch,
      'attemptedOn': attemptedOn?.millisecondsSinceEpoch,
      'challenge': challenge.toMap(),
    };
  }

  factory DailyChallengeModel.fromChallengeModel(ChallengeModel model) {
    return DailyChallengeModel(
      challengeId: model.id!,
      completed: false,
      challenge: model,
    );
  }

  factory DailyChallengeModel.fromMap(Map<String, dynamic> map) {
    return DailyChallengeModel(
      id: map['id'] != null ? map['id'] as String : null,
      challengeId: map['challengeId'] as String,
      completed: map['completed'] as bool,
      completedOn: map['completedOn'] != null
          ? DateTime.parse(map['completedOn']).toLocal()
          : null,
      attemptedOn: map['attemptedOn'] != null
          ? DateTime.parse(map['attemptedOn']).toLocal()
          : null,
      challenge:
          ChallengeModel.fromMap(map['challenge'] as Map<String, dynamic>),
    );
  }

  factory DailyChallengeModel.fromMapAndId(
    String id,
    Map<String, dynamic> map,
  ) {
    return DailyChallengeModel(
      id: id,
      challengeId: map['challengeId'] as String,
      completed: map['completed'] as bool,
      completedOn: map['completedOn'] != null
          ? DateTime.parse(map['completedOn']).toLocal()
          : null,
      attemptedOn: map['attemptedOn'] != null
          ? DateTime.parse(map['attemptedOn']).toLocal()
          : null,
      challenge:
          ChallengeModel.fromMap(map['challenge'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyChallengeModel.fromJson(String source) =>
      DailyChallengeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DailyChallengeModel(id: $id, challengeId: $challengeId, completed: $completed, completedOn: $completedOn, attemptedOn: $attemptedOn, challenge: $challenge)';
  }

  @override
  bool operator ==(covariant DailyChallengeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.challengeId == challengeId &&
        other.completed == completed &&
        other.completedOn == completedOn &&
        other.attemptedOn == attemptedOn &&
        other.challenge == challenge;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        challengeId.hashCode ^
        completed.hashCode ^
        completedOn.hashCode ^
        attemptedOn.hashCode ^
        challenge.hashCode;
  }
}
