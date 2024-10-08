import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_notifier.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/ad_service.dart';
import 'package:practly/core/user/user_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/data/learn_repository.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ExerciseNotifier extends AsyncNotifier<List<Exercise>> {
  final LearnRepository _repository;
  final UserService _databaseService;
  final AdService _adService;

  ExerciseNotifier(
    this._repository,
    this._databaseService,
    this._adService,
  ) : super(_databaseService, _adService);

  int currentExerciseIndex = 0;

  Future<void> getExercises(String lessonId, LessonModel? lesson) async {
    if (lesson != null) {
      final cached = await _databaseService.getCachedExercise(lessonId);
      if (cached != null) {
        execute(() async => cached, isAIGeneration: false);
      } else {
        execute(() => _repository
                .getExercises(
                    lesson: lesson,
                    complexity: locator
                        .get<FirebaseAuthNotifier>()
                        .signedInUser
                        ?.complexity)
                .then((e) {
              _databaseService.setCachedExercise(e);
              return e;
            }));
      }
    } else {
      // add logic to first fetch lesson model by id and then run the logic above
      // only needed for deep-linking
    }
  }

  Future<void> goToNextExercise(BuildContext context, String lessonId) async {
    await state.mapOrNull(data: (val) async {
      if (currentExerciseIndex < val.value.length - 1) {
        currentExerciseIndex++;
        notifyListeners();
      } else {
        await markLessonAsComplete(lessonId);

        if (!context.mounted) return;
        _showCompletionDialog(context);
      }
    });
  }

  void _showCompletionDialog(BuildContext context) {
    final toast = ShadToast.raw(
      title: const Text('Congratulations!'),
      variant: ShadToastVariant.primary,
      description: const Text('You have completed all exercises.'),
      action: ShadButton(
        onPressed: () {
          context.pop();
        },
        child: const Text('Close'),
      ),
    );

    ShadToaster.maybeOf(context)?.show(toast);
  }

  Future<void> markLessonAsComplete(String lessonId) async {
    await _databaseService.markAsDone(lessonId);
  }
}
