import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/user/daily_challenge_model.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/daily_challenge/presentation/challenge_screen.dart';
import 'package:practly/features/learn/data/challenge_model.dart';
import 'package:practly/features/learn/data/learn_repository.dart';

class DailyChallengeNotifier extends AsyncNotifier<DailyChallengeModel?> {
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
    if ((await _databaseService.getGenerationLimit()) == 0) {
      setOutOfCredits();
      return;
    }

    final complexity =
        locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;

    final alreadyOptedChallege = await _databaseService.getDailyChallenge();
    if (alreadyOptedChallege != null) {
      alreadyStartedChallenge = true;
      execute(
        () async => alreadyOptedChallege,
        isAIGeneration: false,
      );
    } else {
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
    ChallengeModel challenge,
  ) async {
    if (!alreadyStartedChallenge) {
      alreadyStartedChallenge = true;
      await _databaseService.setDailyChallenge(challenge);
      await _databaseService.decrementGenerationLimit();
    }

    if (!context.mounted) return;
    context.push(ChallengeScreen.route, extra: challenge);
  }
}
