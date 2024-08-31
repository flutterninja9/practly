import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;
  final String rewardedInterstitialAdId;
  final String minSupportedVersion;
  final int creditsForNewUser;
  final int creditsForAdWatch;
  final bool allowAnonymousSignups;
  final bool inMaintainence;

  Config({
    required this.geminiKey,
    required this.creditsForNewUser,
    required this.creditsForAdWatch,
    required this.rewardedInterstitialAdId,
    required this.allowAnonymousSignups,
    required this.minSupportedVersion,
    required this.inMaintainence,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.fromRemotConfig(Map<String, RemoteConfigValue> map) {
    return Config(
      geminiKey: map["geminiKey"]!.asString(),
      creditsForNewUser: map["creditsForNewUser"]!.asInt(),
      creditsForAdWatch: map["creditsForAdWatch"]!.asInt(),
      rewardedInterstitialAdId: map["rewardedInterstitialAdId"]!.asString(),
      minSupportedVersion: map["minSupportedVersion"]!.asString(),
      allowAnonymousSignups: map["allowAnonymousSignups"]!.asBool(),
      inMaintainence: map["inMaintainence"]!.asBool(),
    );
  }

  @override
  String toString() {
    return 'Config(geminiKey: $geminiKey, rewardedInterstitialAdId: $rewardedInterstitialAdId, minSupportedVersion: $minSupportedVersion, creditsForNewUser: $creditsForNewUser, creditsForAdWatch: $creditsForAdWatch, allowAnonymousSignups: $allowAnonymousSignups, inMaintainence: $inMaintainence)';
  }
}
