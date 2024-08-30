import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:practly/core/config/config.dart';

class ConfigService {
  final FirebaseRemoteConfig remoteConfig;
  final String env;

  ConfigService(
    this.remoteConfig,
    this.env,
  );

  Future<Config> getConfig() async {
    await remoteConfig.fetchAndActivate();
    return Config.fromRemotConfig(remoteConfig.getAll());
  }
}
