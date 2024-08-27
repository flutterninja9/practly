import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable()
class Config {
  final String geminiKey;

  Config({required this.geminiKey});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
