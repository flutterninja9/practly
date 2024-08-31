import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practly/core/constants.dart';

class UserModel {
  final String id;
  final String? name;
  final String? email;
  final String? displayPictureUrl;
  final DateTime createdAt;
  final DateTime lastLogin;
  final SubscriptionInfo subscription;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
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
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'subscription': subscription.toMap(),
      'displayPictureUrl': displayPictureUrl,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? displayPictureUrl,
    DateTime? lastLogin,
    SubscriptionInfo? subscription,
  }) {
    return UserModel(
      id: id,
      displayPictureUrl: displayPictureUrl ?? this.displayPictureUrl,
      name: name ?? this.name,
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
