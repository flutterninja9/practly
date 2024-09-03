import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/features/learn/exercise/buisness_logic/excercise_notifier.dart';
import 'package:practly/features/learn/exercise/presentation/exercise_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'dart:async';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({
    super.key,
    required this.id,
    this.lessonModel,
  });

  final String id;
  final LessonModel? lessonModel;
  static get route => "/lesson/:id";
  static String getRouteById(String id) => "/lesson/$id";

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late final ExerciseNotifier notifier;
  late Timer _timer;

  @override
  void initState() {
    notifier = locator.get();
    super.initState();
    notifier.getExercises(widget.id, widget.lessonModel);
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
                onRetry: () => notifier.getExercises(
                  widget.id,
                  widget.lessonModel,
                ),
                dataBuilder: (model) => ExerciseListWidget(
                  exercises: model,
                  currentIndex: notifier.currentExerciseIndex,
                  onCorrectAnswer: () async {
                    await notifier.goToNextExercise(context, widget.id);
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
