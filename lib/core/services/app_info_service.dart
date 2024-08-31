import 'package:package_info_plus/package_info_plus.dart';
import 'package:practly/core/config/config.dart';
import 'package:version/version.dart';

class AppInfoService {
  final Config _config;

  AppInfoService(this._config);

  Future<Version> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return Version.parse(packageInfo.version);
  }

  Future<bool> isUpdateRequired() async {
    final requiredVersion = Version.parse(_config.minSupportedVersion);
    final currentVersion = await getCurrentVersion();

    return currentVersion.compareTo(requiredVersion) < 0;
  }
}
