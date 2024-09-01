import 'package:flutter/material.dart';
import 'package:practly/features/learn/presentation/word_of_the_day_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  static String get route => "/learn";

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          WordOfTheDayScreen(),
        ],
      ),
    );
  }
}
