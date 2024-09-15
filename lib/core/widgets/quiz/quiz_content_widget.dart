import 'package:flutter/material.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizContentWidget extends StatelessWidget {
  const QuizContentWidget({
    super.key,
    required this.model,
    required this.selectedAnswer,
    required this.isAnswerSelected,
    required this.onAnswerSelected,
    required this.showCorrectAnwer,
  });

  final QuizModel model;
  final String? selectedAnswer;
  final bool isAnswerSelected;
  final bool showCorrectAnwer;
  final Function(String) onAnswerSelected;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadCard(
            padding: const EdgeInsets.all(18),
            child: Text(
              model.sentence,
              style: ShadTheme.of(context).textTheme.h3,
            ),
          ),
          const SizedBox(height: 20),
          ...model.options.entries.map((entry) {
            final tileColor = _getTileColor(entry);

            return ListTile(
              title: Text(
                '${entry.key}) ${entry.value}',
                style: ShadTheme.of(context).textTheme.p,
              ),
              tileColor: tileColor,
              onTap:
                  isAnswerSelected ? null : () => onAnswerSelected(entry.key),
            );
          }),
        ],
      ),
    );
  }

  Color? _getTileColor(MapEntry<String, String> entry) {
    if (!isAnswerSelected) return null;

    final bool isSelected = selectedAnswer == entry.key;
    final bool isCorrect = entry.key == model.correctAnswer;

    if (showCorrectAnwer) {
      return _getColorForCorrectAnswerShown(isCorrect, isSelected);
    } else {
      return _getColorForSelectedAnswer(isSelected, isCorrect);
    }
  }

  Color? _getColorForCorrectAnswerShown(bool isCorrect, bool isSelected) {
    if (isCorrect) return const Color(0xFFA5D6A7);
    if (isSelected) return const Color(0xFFEF9A9A);
    return null;
  }

  Color? _getColorForSelectedAnswer(bool isSelected, bool isCorrect) {
    if (!isSelected) return null;
    return isCorrect ? const Color(0xFFA5D6A7) : const Color(0xFFEF9A9A);
  }
}
