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

  ChallengeNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  int currentExerciseIndex = 0;

  Future<void> getExercises(DailyChallengeModel? model) async {
    execute(() async => model!.challenge.questions!, isAIGeneration: false);
  }

  Future<void> goToNextExercise(
    BuildContext context,
    String challengeId,
  ) async {
    await state.mapOrNull(data: (val) async {
      if (currentExerciseIndex < val.value.length - 1) {
        currentExerciseIndex++;
        notifyListeners();
      } else {
        await _databaseService.markDailyChallengeComplete(challengeId);
        await _databaseService.updateGenerationLimit(
          by: kDailyChallengeCompletePoints,
        );

        if (!context.mounted) return;
        _showCompletionDialog(context);
      }
    });
  }

  void _showCompletionDialog(BuildContext context) {
    final toast = ShadToast.raw(
      title: const Text('Congratulations!'),
      variant: ShadToastVariant.primary,
      description: const Text('You have completed all challenges.'),
      action: ShadButton(
        onPressed: () {
          context.pop();
        },
        child: const Text('Close'),
      ),
    );

    ShadToaster.maybeOf(context)?.show(toast);
  }
}
