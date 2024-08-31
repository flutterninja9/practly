import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;
  final int creditsForNewUser;
  final int creditsForAdWatch;

  Config({
    required this.geminiKey,
    required this.creditsForNewUser,
    required this.creditsForAdWatch,
  });

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.fromRemotConfig(Map<String, RemoteConfigValue> map) {
    return Config(
      geminiKey: map["geminiKey"]!.asString(),
      creditsForNewUser: map["creditsForNewUser"]!.asInt(),
      creditsForAdWatch: map["creditsForAdWatch"]!.asInt(),
    );
  }

  @override
  String toString() =>
      'Config(geminiKey: $geminiKey, creditsForNewUser: $creditsForNewUser, creditsForAdWatch: $creditsForAdWatch)';
}
