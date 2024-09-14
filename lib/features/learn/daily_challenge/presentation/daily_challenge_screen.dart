import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_challenge/buisness_logic/daily_challenge_notifier.dart';
import 'package:practly/features/learn/daily_challenge/presentation/daily_challenge_card.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen>
    with AutomaticKeepAliveClientMixin {
  late final DailyChallengeNotifier _dailyChallengeNotifier;

  @override
  void initState() {
    super.initState();
    _dailyChallengeNotifier = locator.get()..getDailyChallenge();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedBuilder(
          animation: _dailyChallengeNotifier,
          builder: (context, child) {
            return AsyncPage(
              asyncValue: _dailyChallengeNotifier.state,
              loadingBuilder: () => const SizedBox.shrink(),
              errorBuilder: () => const SizedBox.shrink(),
              outOfCreditsBuilder: () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(title: 'Daily Challenge!'),
                    const SizedBox(height: 20),
                    DailyChallengeCard(
                      onTap: _dailyChallengeNotifier.watchAdAndContinue,
                      buttonLabel: "Watch ad to start challenge",
                      buttonIcon: LucideIcons.play,
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
              dataBuilder: (data) {
                if (data == null) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(title: 'Daily Challenge!'),
                    const SizedBox(height: 20),
                    DailyChallengeCard(
                      onTap: () => _dailyChallengeNotifier.onStartChallenge(
                        context,
                        data,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
