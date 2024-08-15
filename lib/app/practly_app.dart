import 'package:flutter/material.dart';
import 'package:practly/screens/home_screen.dart';

class PractlyApp extends StatelessWidget {
  const PractlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeakEase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
