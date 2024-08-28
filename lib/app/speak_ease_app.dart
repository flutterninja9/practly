import 'package:flutter/material.dart';
import 'package:practly/features/home/presentation/home_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpeakEaseApp extends StatelessWidget {
  const SpeakEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadApp.material(
      title: 'SpeakEase',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
