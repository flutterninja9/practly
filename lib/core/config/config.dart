import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;
  final String rewardedInterstitialAdId;
  final int creditsForNewUser;
  final int creditsForAdWatch;

  Config({
    required this.geminiKey,
    required this.creditsForNewUser,
    required this.creditsForAdWatch,
    required this.rewardedInterstitialAdId,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.fromRemotConfig(Map<String, RemoteConfigValue> map) {
    return Config(
      geminiKey: map["geminiKey"]!.asString(),
      creditsForNewUser: map["creditsForNewUser"]!.asInt(),
      creditsForAdWatch: map["creditsForAdWatch"]!.asInt(),
      rewardedInterstitialAdId: map["rewardedInterstitialAdId"]!.asString(),
    );
  }

  @override
  String toString() {
    return 'Config(geminiKey: $geminiKey, rewardedInterstitialAdId: $rewardedInterstitialAdId, creditsForNewUser: $creditsForNewUser, creditsForAdWatch: $creditsForAdWatch)';
  }
}
