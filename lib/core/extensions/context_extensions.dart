import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  bool get isDarkMode {
    return MediaQuery.maybeOf(this)?.platformBrightness == Brightness.dark;
  }
}
