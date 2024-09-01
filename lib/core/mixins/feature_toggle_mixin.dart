import 'package:practly/core/config/config.dart';
import 'package:practly/di/di.dart';

mixin FeatureToggleMixin {
  bool isEnabled(String featureName) {
    try {
      return locator.get<Config>().featureToggles[featureName] ?? false;
    } catch (e) {
      return false;
    }
  }
}
