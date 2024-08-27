import 'package:flutter/material.dart';
import 'package:practly/features/home/presentation/home_screen.dart';

class SpeakEaseApp extends StatelessWidget {
  const SpeakEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeakEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
