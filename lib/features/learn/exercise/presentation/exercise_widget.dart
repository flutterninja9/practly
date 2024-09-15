import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';
import 'package:practly/core/widgets/quiz/quiz_excercise_screen.dart';
import 'package:practly/core/widgets/speak/speak_excercise_screen.dart';

class ExerciseListWidget extends StatelessWidget {
  final int currentIndex;
  final List<Exercise> exercises;
  final Function((Exercise question, bool correct)) onAnswer;
  final bool showCorrectAnswer;

  const ExerciseListWidget({
    super.key,
    required this.exercises,
    required this.currentIndex,
    required this.onAnswer,
    this.showCorrectAnswer = true,
  });

  Widget _buildExerciseWidget(Exercise exercise) {
    switch (exercise.type) {
      case 'quiz':
        return QuizExcerciseScreen(
          key: ObjectKey(exercise),
          model: exercise as QuizModel,
          autoNext: false,
          showCorrectAnswer: showCorrectAnswer,
          onRequestNext: (isCorrect) async =>
              await onAnswer((exercise, isCorrect)),
        );
      case 'sentence':
        return SpeakExcerciseScreen(
          key: ObjectKey(exercise),
          model: exercise as SpeakOutAloudModel,
          onRequestNext: () async {
            await onAnswer((exercise, true));
          },
        );
      default:
        return Center(
          child: Text('Unsupported exercise type: ${exercise.type}'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShadProgress(
          value: (currentIndex + 1) / exercises.length,
        ),
        Expanded(
          child: _buildExerciseWidget(exercises[currentIndex]),
        ),
      ],
    );
  }
}
