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
  ChallengeNotifier(this._repository, this._userService, this._adService)
      : super(_userService, _adService);

  final LearnRepository _repository;
  final UserService _userService;
  final AdService _adService;

  int _currentExerciseIndex = 0;
  final Map<Exercise, bool> _results = {};

  int get currentExerciseIndex => _currentExerciseIndex;

  Future<void> getExercises(DailyChallengeModel? model) async {
    execute(() async => model!.challenge.questions!, isAIGeneration: false);
  }

  bool _allCorrect() => _results.values.every((result) => result);
  int _correctCount() => _results.values.where((result) => result).length;

  Future<void> goToNextExercise(
    BuildContext context,
    String challengeId,
    Exercise lastQuestion,
    bool answeredCorrectly,
    int currentAttempt,
  ) async {
    _results[lastQuestion] = answeredCorrectly;

    await state.mapOrNull(data: (val) async {
      if (_currentExerciseIndex < val.value.length - 1) {
        _currentExerciseIndex++;
        notifyListeners();
      } else {
        await _handleChallengeCompletion(context, challengeId, currentAttempt);
      }
    });
  }

  Future<void> _handleChallengeCompletion(
    BuildContext context,
    String challengeId,
    int currentAttempt,
  ) async {
    if (_allCorrect()) {
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

    await Future.delayed(const Duration(seconds: 1), () => context.pop());
  }

  Future<void> _markCompleteAndCreditPoints(String challengeId) async {
    await _markComplete(challengeId);
    await _userService.updateGenerationLimit(by: kDailyChallengeCompletePoints);
  }

  Future<void> _markComplete(String challengeId) async {
    await _userService.markDailyChallengeComplete(challengeId);
  }

  void _showCompletionDialog(BuildContext context) {
    _showToast(
      context,
      title: 'Congratulations!',
      description: 'You have completed all challenges. 🎉',
    );
  }

  void _showIncorrectAnswersDialog(
      BuildContext context, int remainingAttempts) {
    final incorrectAnswers = _results.length - _correctCount();
    final description =
        _buildIncorrectAnswersDescription(incorrectAnswers, remainingAttempts);

    _showToast(
      context,
      title: 'Quiz Completed!',
      description: description,
      duration: const Duration(seconds: 6),
    );
  }

  String _buildIncorrectAnswersDescription(
      int incorrectAnswers, int remainingAttempts) {
    final baseDescription = incorrectAnswers > 0
        ? 'You have completed the quiz with $incorrectAnswers incorrect answers.'
        : 'You have completed the quiz with all correct answers.';

    final retryMessage = remainingAttempts > 0
        ? ' You still have $remainingAttempts attempt(s) remaining.'
        : '';

    return baseDescription + retryMessage;
  }

  void _showToast(
    BuildContext context, {
    required String title,
    required String description,
    Duration duration = const Duration(seconds: 3),
  }) {
    final toast = ShadToast.raw(
      title: Text(title),
      variant: ShadToastVariant.primary,
      description: Text(description),
      duration: duration,
    );

    ShadToaster.maybeOf(context)?.show(toast);
  }
}
