import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:practly/core/constants.dart';
import 'package:practly/core/enums/enums.dart';

class UserModel {
  final String id;
  final String? name;
  final String? email;
  final Complexity? complexity;
  final String? displayPictureUrl;
  final Progress? progress;
  final DateTime createdAt;
  final DateTime lastLogin;
  final SubscriptionInfo subscription;

  UserModel({
    required this.id,
    required this.name,
    required this.complexity,
    required this.email,
    required this.createdAt,
    required this.progress,
    required this.lastLogin,
    required this.subscription,
    required this.displayPictureUrl,
  });

  factory UserModel.fromEmailAndId({
    required String id,
    required int creditsForNewUser,
    String? email,
    String? name,
    String? dpUrl,
  }) {
    return UserModel(
      id: id,
      name: name,
      email: email,
      progress: null,
      complexity: null,
      displayPictureUrl: dpUrl,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      subscription: SubscriptionInfo.empty(creditsForNewUser),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return UserModel(
      id: id,
      name: map['name'],
      complexity: map['complexity'] != null
          ? Complexity.fromString(map['complexity'])
          : map['complexity'],
      progress:
          map['progress'] != null ? Progress.fromMap(map['progress']) : null,
      displayPictureUrl: map['displayPictureUrl'] ?? kFallbackProfileImageUrl,
      email: map['email'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: (map['lastLogin'] as Timestamp).toDate(),
      subscription: SubscriptionInfo.fromMap(map['subscription'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'complexity': complexity,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'subscription': subscription.toMap(),
      'displayPictureUrl': displayPictureUrl,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    Complexity? complexity,
    String? displayPictureUrl,
    DateTime? lastLogin,
    Progress? progress,
    SubscriptionInfo? subscription,
  }) {
    return UserModel(
      id: id,
      displayPictureUrl: displayPictureUrl ?? this.displayPictureUrl,
      name: name ?? this.name,
      complexity: complexity ?? this.complexity,
      progress: progress ?? this.progress,
      email: email ?? this.email,
      createdAt: createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      subscription: subscription ?? this.subscription,
    );
  }
}

class SubscriptionInfo {
  final String type; // 'free', 'paid'
  final DateTime? expiresAt;
  final int generationLimit;

  SubscriptionInfo({
    required this.type,
    required this.generationLimit,
    this.expiresAt,
  });

  factory SubscriptionInfo.empty(int creditsForNewUser) {
    return SubscriptionInfo(type: 'free', generationLimit: creditsForNewUser);
  }

  factory SubscriptionInfo.fromMap(Map<String, dynamic> map) {
    return SubscriptionInfo(
      type: map['type'] ?? 'free',
      generationLimit: map['generationLimit'] ?? 10,
      expiresAt: map['expiresAt'] != null
          ? (map['expiresAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'generationLimit': generationLimit,
    };
  }

  SubscriptionInfo copyWith({
    String? type,
    DateTime? expiresAt,
    int? generationLimit,
  }) {
    return SubscriptionInfo(
      type: type ?? this.type,
      generationLimit: generationLimit ?? this.generationLimit,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class Progress {
  final String? currentLesson;
  final List<String>? completedLessons;

  Progress({
    required this.currentLesson,
    required this.completedLessons,
  });

  Progress copyWith({
    String? currentLesson,
    List<String>? completedLessons,
  }) {
    return Progress(
      currentLesson: currentLesson ?? this.currentLesson,
      completedLessons: completedLessons ?? this.completedLessons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentLesson': currentLesson,
      'completedLessons': completedLessons,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
        currentLesson: map['currentLesson'] as String?,
        completedLessons: map['completedLessons'] != null
            ? List<String>.from(
                (map['completedLessons'] as List),
              )
            : []);
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Progress(currentLesson: $currentLesson, completedLessons: $completedLessons)';

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.currentLesson == currentLesson &&
        listEquals(other.completedLessons, completedLessons);
  }

  @override
  int get hashCode => currentLesson.hashCode ^ completedLessons.hashCode;
}
