import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;

  Config({required this.geminiKey});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.fromRemotConfig(Map<String, RemoteConfigValue> map) {
    return Config(geminiKey: map["geminiKey"]!.asString());
  }

  @override
  String toString() => 'Config(geminiKey: $geminiKey)';
}
