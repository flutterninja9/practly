import 'package:flutter/material.dart';
import 'package:practly/core/widgets/header.dart';

class ContextualChallengesScreen extends StatefulWidget {
  const ContextualChallengesScreen({super.key});

  @override
  State<ContextualChallengesScreen> createState() =>
      _ContextualChallengesScreenState();
}

class _ContextualChallengesScreenState
    extends State<ContextualChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: 'Daily Dialogues'),
        SizedBox(height: 20),
      ],
    );
  }
}
