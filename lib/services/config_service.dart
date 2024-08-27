import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:practly/config/config.dart';

import 'package:practly/config/env.dart';

class ConfigService {
  final FirebaseRemoteConfig remoteConfig;
  final Env env;

  ConfigService(
    this.remoteConfig,
    this.env,
  );

  Future<Config> getConfig() async {
    await remoteConfig.fetchAndActivate();
    return Config.fromJson(jsonDecode(remoteConfig.getString(env.value)));
  }
}
