import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ScoreDisplay extends StatelessWidget {
  final int score;

  const ScoreDisplay({super.key, required this.score});

  String get feedbackMessage {
    if (score >= 9) {
      return "You're a star! 🌟";
    } else if (score >= 6) {
      return "Great job! Keep it up!";
    } else {
      return "Almost there! Keep practicing!";
    }
  }

  Color get scoreColor {
    if (score >= 9) {
      return Colors.greenAccent;
    } else if (score >= 6) {
      return Colors.orangeAccent;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (score == 0) {
      return const SizedBox.shrink();
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          feedbackMessage,
          textAlign: TextAlign.center,
          style: ShadTheme.of(context).textTheme.h4,
        ),
      ),
    );
  }
}
