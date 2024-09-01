import 'package:flutter/material.dart';
import 'package:practly/features/learn/presentation/word_of_the_day_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  static String get route => "/learn";

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final _contents = <Widget>[
    const WordOfTheDayScreen(),
    // const ContextualChallengesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => const SizedBox(height: 40),
        itemCount: _contents.length,
        itemBuilder: (context, index) => _contents[index],
      ),
    );
  }
}
