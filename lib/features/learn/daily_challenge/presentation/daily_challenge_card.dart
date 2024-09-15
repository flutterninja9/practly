import 'package:flutter/material.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/extensions/string_extensions.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    super.key,
    required this.onTap,
    this.complexity = Complexity.easy,
    this.buttonLabel = "Start Challenge",
    this.buttonIcon = LucideIcons.zap,
    this.model,
  });

  final Function() onTap;
  final Complexity complexity;
  final String buttonLabel;
  final DailyChallengeModel? model;
  final IconData buttonIcon;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: theme.cardTheme.padding?.copyWith(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            "Ready to take up the challenge?",
            style: theme.textTheme.list.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: theme.textTheme.list,
              children: [
                const TextSpan(
                    text: "🎯 Challenge: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        "${model?.challenge.questions?.length ?? 5} questions\n"),
                const TextSpan(
                    text: "💪 Difficulty: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "${complexity.name.capitalize()}\n"),
                if (model != null)
                  const TextSpan(
                      text: "🔄 Attempts: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                if (model != null)
                  TextSpan(
                      text: "${model?.attempts}/$kMaxDailyChallengeAttempts\n"),
                const TextSpan(
                    text: "🏆 Reward: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: "$kDailyChallengeCompletePoints Credits"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ShadButton.raw(
            width: double.infinity,
            variant: ShadButtonVariant.primary,
            onPressed: onTap,
            icon: Icon(buttonIcon),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
