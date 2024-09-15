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

  Future<void> _onExit() async {
    final wantsToExit = (await showShadDialog(
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ShadDialog.alert(
              title: const Text('Exit Challenge?'),
              description: const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'You’re in the middle of today’s challenge. If you exit now, your progress will be lost and one attempt will be used. Do you still want to leave?',
                ),
              ),
              actions: [
                ShadButton.outline(
                  child: const Text('Stay and Continue'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                ShadButton(
                  child: const Text('Exit Challenge'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ),
        ) ??
        false);

    if (wantsToExit) {
      context.pop();
    }
  }

  @override
  void initState() {
    notifier = locator.get();
    super.initState();
    notifier.getExercises(widget.challengeModel);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.circleX),
              onPressed: _onExit,
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
                    showCorrectAnswer: false,
                    currentIndex: notifier.currentExerciseIndex,
                    onAnswer: (doc) async {
                      await notifier.goToNextExercise(
                        context,
                        widget.challengeModel!.id!,
                        doc.$1,
                        doc.$2,
                        widget.challengeModel!.attempts + 1,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
