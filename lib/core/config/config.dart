// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;
  final String rewardedInterstitialAdId;
  final int creditsForNewUser;
  final int creditsForAdWatch;
  final bool allowAnonymousSignups;

  Config({
    required this.geminiKey,
    required this.creditsForNewUser,
    required this.creditsForAdWatch,
    required this.rewardedInterstitialAdId,
    required this.allowAnonymousSignups,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.fromRemotConfig(Map<String, RemoteConfigValue> map) {
    return Config(
      geminiKey: map["geminiKey"]!.asString(),
      creditsForNewUser: map["creditsForNewUser"]!.asInt(),
      creditsForAdWatch: map["creditsForAdWatch"]!.asInt(),
      rewardedInterstitialAdId: map["rewardedInterstitialAdId"]!.asString(),
      allowAnonymousSignups: map["allowAnonymousSignups"]!.asBool(),
    );
  }

  @override
  String toString() {
    return 'Config(geminiKey: $geminiKey, rewardedInterstitialAdId: $rewardedInterstitialAdId, creditsForNewUser: $creditsForNewUser, creditsForAdWatch: $creditsForAdWatch, allowAnonymousSignups: $allowAnonymousSignups)';
  }
}
