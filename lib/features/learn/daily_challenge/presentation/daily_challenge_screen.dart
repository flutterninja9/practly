import 'package:flutter/material.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/features/learn/daily_challenge/presentation/daily_challenge_card.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: 'Daily Challenge!'),
        const SizedBox(height: 20),
        DailyChallengeCard(onTap: () {}),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
