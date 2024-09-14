import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_challenge/buisness_logic/challenge_notifier.dart';
import 'package:practly/features/learn/exercise/presentation/exercise_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({
    super.key,
    this.challengeModel,
  });

  final DailyChallengeModel? challengeModel;
  static get route => "/challenge";

  @override
  State<ChallengeScreen> createState() => ChallengeScreenState();
}

class ChallengeScreenState extends State<ChallengeScreen> {
  late final ChallengeNotifier notifier;

  @override
  void initState() {
    notifier = locator.get();
    super.initState();
    notifier.getExercises(widget.challengeModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.circleX),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: notifier,
            builder: (context, child) {
              return AsyncPage(
                asyncValue: notifier.state,
                onRetry: () => notifier.getExercises(widget.challengeModel),
                dataBuilder: (model) => ExerciseListWidget(
                  exercises: model,
                  currentIndex: notifier.currentExerciseIndex,
                  onCorrectAnswer: () async {
                    await notifier.goToNextExercise(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
