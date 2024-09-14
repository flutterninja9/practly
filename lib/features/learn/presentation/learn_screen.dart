import 'package:flutter/material.dart';
import 'package:practly/features/learn/daily_challenge/presentation/daily_challenge_screen.dart';
import 'package:practly/features/learn/daily_dialogs/presentation/dialy_dialogs_screen.dart';
import 'package:practly/features/learn/word/presentation/word_of_the_day_screen.dart';

class LearnScreen extends StatelessWidget {
  LearnScreen({super.key});

  static String get route => "/learn";

  final List<Widget> _contents = [
    const DailyChallengeScreen(),
    const WordOfTheDayScreen(),
    const DailyDialogsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _contents.length,
        itemBuilder: (context, index) => _contents[index],
      ),
    );
  }
}
