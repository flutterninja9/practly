import 'package:flutter/material.dart';
import 'package:practly/core/widgets/quiz/quiz_content_widget.dart';
import 'package:practly/core/widgets/quiz/quiz_excercise_viewmodel.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizExcerciseScreen extends StatefulWidget {
  const QuizExcerciseScreen({
    super.key,
    required this.model,
    required this.autoNext,
    required this.onRequestNext,
    this.showCorrectAnswer = true,
  });

  final QuizModel model;
  final bool autoNext;
  final bool showCorrectAnswer;
  final Function() onRequestNext;

  @override
  State<QuizExcerciseScreen> createState() => _QuizExcerciseScreenState();
}

class _QuizExcerciseScreenState extends State<QuizExcerciseScreen> {
  late final QuizExcerciseViewModel viewModel;

  @override
  void initState() {
    viewModel = QuizExcerciseViewModel(
      widget.model,
      widget.autoNext,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: viewModel,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: QuizContentWidget(
                  model: widget.model,
                  showCorrectAnwer: widget.showCorrectAnswer,
                  selectedAnswer: viewModel.selectedAnswer,
                  isAnswerSelected: viewModel.isAnswerSelected,
                  onAnswerSelected: (val) =>
                      viewModel.handleOptionSelected(val, widget.onRequestNext),
                ),
              ),
              if (!widget.autoNext && viewModel.isAnswerSelected)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ShadButton.link(
                      onPressed: widget.onRequestNext,
                      child: const Text("Next"),
                    )
                  ],
                ),
            ],
          );
        });
  }
}
