// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/mixins/feature_toggle_mixin.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_challenge/presentation/challenge_screen.dart';
import 'package:practly/features/learn/data/learn_repository.dart';

class DailyChallengeNotifier extends AsyncNotifier<DailyChallengeModel?>
    with FeatureToggleMixin {
  final LearnRepository _repository;
  final UserService _databaseService;
  final AdService _adService;

  bool alreadyStartedChallenge = false;

  DailyChallengeNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> getDailyChallenge() async {
    if (!isEnabled(kDialyChallengeFeatureConstant)) {
      setLoading();
      return;
    }

    final alreadyOptedChallenge = await _fetchExistingChallenge();
    if (alreadyOptedChallenge != null) {
      _handleExistingChallenge(alreadyOptedChallenge);
    } else {
      _handleNewChallenge();
    }
  }

  Future<DailyChallengeModel?> _fetchExistingChallenge() async {
    return await _databaseService.getDailyChallenge();
  }

  void _handleExistingChallenge(DailyChallengeModel challenge) {
    if (challenge.completed) {
      setLoading(); // Challenge already completed
      return;
    }

    /// If reached max attempts return
    final maxAttemptsReached = _checkMaxAttempts(challenge);
    if (maxAttemptsReached) {
      setLoading();
      return;
    }

    alreadyStartedChallenge = true;
    execute(() async => challenge, isAIGeneration: false);
  }

  Future<void> _handleNewChallenge() async {
    if ((await _databaseService.getGenerationLimit()) == 0) {
      setOutOfCredits();
      return;
    }

    final complexity =
        locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;
    execute(
      () => _repository.getDailyChallenge(complexity: complexity),
      isAIGeneration: false,
    );
  }

  Future<void> watchAdAndContinue() async {
    await _adService.loadAndShowRewardedAd(getDailyChallenge);
  }

  Future<void> onStartChallenge(
    BuildContext context,
    DailyChallengeModel challenge,
  ) async {
    if (!alreadyStartedChallenge) {
      final modelWithId = await _startNewChallenge(challenge);
      await _proceedToChallenge(context, modelWithId ?? challenge);
    } else {
      await _incrementChallengeAttempts(challenge);
      await _proceedToChallenge(context, challenge);
    }

    getDailyChallenge();
  }

  Future<DailyChallengeModel?> _startNewChallenge(
    DailyChallengeModel challenge,
  ) async {
    alreadyStartedChallenge = true;
    final modelWithId = await _databaseService.setDailyChallenge(challenge);
    await _databaseService.decrementGenerationLimit();
    execute(() async => modelWithId, isAIGeneration: false);
    return modelWithId;
  }

  Future<void> _proceedToChallenge(
    BuildContext context,
    DailyChallengeModel challenge,
  ) async {
    if (!context.mounted) return;
    await context.push(ChallengeScreen.route, extra: challenge);
  }

  bool _checkMaxAttempts(DailyChallengeModel challenge) {
    final attempts = challenge.attempts;
    return attempts >= kMaxDailyChallengeAttempts;
  }

  Future<void> _incrementChallengeAttempts(
    DailyChallengeModel challenge,
  ) async {
    await _databaseService.updateAttempts(
        challenge.id!, challenge.attempts + 1);
  }
}
