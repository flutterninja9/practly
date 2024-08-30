import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextX on BuildContext {
  bool get isDarkMode {
    return MediaQuery.maybeOf(this)?.platformBrightness == Brightness.dark;
  }

  String get currentRoute {
    return GoRouter.of(this).routerDelegate.currentConfiguration.uri.toString();
  }
}
