// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/features/learn/data/learn_repository.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChallengeNotifier extends AsyncNotifier<List<Exercise>> {
  final LearnRepository _repository;
  final UserService _databaseService;
  final AdService _adService;
  final Map<Exercise, bool> _results = {};

  ChallengeNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  int currentExerciseIndex = 0;

  Future<void> getExercises(DailyChallengeModel? model) async {
    execute(() async => model!.challenge.questions!, isAIGeneration: false);
  }

  bool allCorrect() {
    return _results.values.every((result) => result);
  }

  int correctCount() {
    return _results.values.where((result) => result).length;
  }

  Future<void> goToNextExercise(
    BuildContext context,
    String challengeId,
    Exercise lastQuestion,
    bool answeredCorrectly,
    int currentAttempt,
  ) async {
    _results[lastQuestion] = answeredCorrectly;

    await state.mapOrNull(data: (val) async {
      if (currentExerciseIndex < val.value.length - 1) {
        currentExerciseIndex++;
        notifyListeners();
      } else {
        if (allCorrect()) {
          await _markCompleteAndCreditPoints(challengeId);
          _showCompletionDialog(context);
        } else {
          if (currentAttempt >= kMaxDailyChallengeAttempts) {
            await _markComplete(challengeId);
          }

          _showIncorrectAnswersDialog(
            context,
            kMaxDailyChallengeAttempts - currentAttempt,
          );
        }

        await Future.delayed(const Duration(seconds: 1), () {
          context.pop();
        });
      }
    });
  }

  Future<void> _markCompleteAndCreditPoints(String challengeId) async {
    await _markComplete(challengeId);
    await _databaseService.updateGenerationLimit(
      by: kDailyChallengeCompletePoints,
    );
  }

  Future<void> _markComplete(String challengeId) async {
    await _databaseService.markDailyChallengeComplete(challengeId);
  }

  void _showCompletionDialog(BuildContext context) {
    const toast = ShadToast.raw(
      title: Text('Congratulations!'),
      variant: ShadToastVariant.primary,
      description: Text('You have completed all challenges. 🎉'),
    );

    ShadToaster.maybeOf(context)?.show(toast);
  }

  void _showIncorrectAnswersDialog(
    BuildContext context,
    int remainingAttempts,
  ) {
    final incorrectAnswers = _results.values.length - correctCount();
    final description = incorrectAnswers > 0
        ? 'You have completed the quiz with $incorrectAnswers incorrect answers.'
        : 'You have completed the quiz with all correct answers.';

    final retryMessage = remainingAttempts > 0
        ? ' You still have $remainingAttempts attempt(s) remaining.'
        : '';

    final toast = ShadToast.raw(
      title: const Text('Quiz Completed!'),
      duration: const Duration(seconds: 6),
      variant: ShadToastVariant.primary,
      description: Text(description + retryMessage),
    );

    ShadToaster.maybeOf(context)?.show(toast);
  }
}
