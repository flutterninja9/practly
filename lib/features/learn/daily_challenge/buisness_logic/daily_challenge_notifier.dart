import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
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
  final FirebaseAuthNotifier _authNotifier;
  final AdService _adService;

  bool alreadyStartedChallenge = false;

  DailyChallengeNotifier(
    this._repository,
    this._databaseService,
    this._authNotifier,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> getDailyChallenge() async {
    if (!isEnabled("challenge")) {
      setLoading();
      return;
    }

    final complexity =
        locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

    final alreadyOptedChallege = await _databaseService.getDailyChallenge();
    if (alreadyOptedChallege != null) {
      if (alreadyOptedChallege.completed) {
        // use has already completed challenge for the day
        setLoading();
        return;
      }

      alreadyStartedChallenge = true;
      execute(
        () async => alreadyOptedChallege,
        isAIGeneration: false,
      );
    } else {
      if ((await _databaseService.getGenerationLimit()) == 0) {
        setOutOfCredits();
        return;
      }

      execute(
        () => _repository.getDailyChallenge(complexity: complexity),
        isAIGeneration: false,
      );
    }
  }

  Future<void> watchAdAndContinue() async {
    await _adService.loadAndShowRewardedAd(getDailyChallenge);
  }

  Future<void> onStartChallenge(
    BuildContext context,
    DailyChallengeModel challenge,
  ) async {
    DailyChallengeModel? modelWithId;

    if (!alreadyStartedChallenge) {
      alreadyStartedChallenge = true;
      modelWithId = await _databaseService.setDailyChallenge(challenge);
      await _databaseService.decrementGenerationLimit();
      execute(() async => modelWithId, isAIGeneration: false);
    }

    if (!context.mounted) return;
    await context.push(ChallengeScreen.route, extra: modelWithId ?? challenge);
    getDailyChallenge();
  }
}
