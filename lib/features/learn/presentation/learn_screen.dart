import 'package:flutter/material.dart';
import 'package:practly/core/mixins/feature_toggle_mixin.dart';
import 'package:practly/features/learn/daily_challenge/presentation/daily_challenge_screen.dart';
import 'package:practly/features/learn/daily_dialogs/presentation/dialy_dialogs_screen.dart';
import 'package:practly/features/learn/word/presentation/word_of_the_day_screen.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  static String get route => "/learn";

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> with FeatureToggleMixin {
  late List<Widget> _contents;

  @override
  void initState() {
    _contents = <Widget>[
      if (isEnabled("challenge")) const DailyChallengeScreen(),
      const WordOfTheDayScreen(),
      const DailyDialogsScreen(),
    ];
    super.initState();
  }

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
