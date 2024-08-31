// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      geminiKey: json['geminiKey'] as String,
      creditsForNewUser: (json['creditsForNewUser'] as num).toInt(),
      creditsForAdWatch: (json['creditsForAdWatch'] as num).toInt(),
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'geminiKey': instance.geminiKey,
      'creditsForNewUser': instance.creditsForNewUser,
      'creditsForAdWatch': instance.creditsForAdWatch,
    };
