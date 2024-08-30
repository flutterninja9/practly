import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/di/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpeakEaseApp extends StatelessWidget {
  const SpeakEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = locator.get<GoRouter>();

    return ShadApp.materialRouter(
      title: 'SpeakEase',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
