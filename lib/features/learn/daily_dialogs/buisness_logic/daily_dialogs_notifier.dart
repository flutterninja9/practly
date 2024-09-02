import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/services/database_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/data/learn_repository.dart';
import 'package:practly/features/learn/exercise/presentation/exercise_screen.dart';

class DailyDialogsNotifier extends AsyncNotifier<List<LessonModel>> {
  final LearnRepository _repository;
  final DatabaseService _databaseService;
  final FirebaseAuthNotifier _authNotifier;
  final AdService _adService;

  DailyDialogsNotifier(
    this._repository,
    this._databaseService,
    this._authNotifier,
    this._adService,
  ) : super(_databaseService, _adService);

  Future<void> getDailyDialogs() async {
    final complexity = locator.get<FirebaseAuthNotifier>().signedInUser?.complexity;
    
    execute(
      () => _repository.getDailyDialogs(complexity: complexity),
      isAIGeneration: false,
    );
  }

  bool alreadyEnrolled(String id) {
    final currentuser = locator.get<FirebaseAuthNotifier>().signedInUser;
    final alreadyEnrolled = currentuser?.progress?.currentLesson == id;

    return alreadyEnrolled;
  }

  bool alreadyCompleted(String id) {
    final currentuser = locator.get<FirebaseAuthNotifier>().signedInUser;
    final alreadyCompleted =
        (currentuser?.progress?.completedLessons?.contains(id) ?? false);

    return alreadyCompleted;
  }

  Future<void> onStartLesson(
    String id,
    BuildContext context,
  ) async {
    if (!alreadyEnrolled(id)) {
      await _databaseService.setEnrollment(id);
      _authNotifier.signedInUser =
          await _databaseService.getUserProfile(_authNotifier.signedInUser!.id);
    }

    if (!context.mounted) return;
    await context.push(ExerciseScreen.getRouteById(id));
    getDailyDialogs();
  }
}
