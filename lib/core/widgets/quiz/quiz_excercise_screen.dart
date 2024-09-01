import 'package:flutter/material.dart';
import 'package:practly/core/widgets/quiz/quiz_content_widget.dart';
import 'package:practly/core/widgets/quiz/quiz_excercise_viewmodel.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class QuizExcerciseScreen extends StatefulWidget {
  const QuizExcerciseScreen({
    super.key,
    required this.model,
    required this.onRequestNext,
  });

  final QuizModel model;
  final Function() onRequestNext;

  @override
  State<QuizExcerciseScreen> createState() => _QuizExcerciseScreenState();
}

class _QuizExcerciseScreenState extends State<QuizExcerciseScreen> {
  late final QuizExcerciseViewModel viewModel;

  @override
  void initState() {
    viewModel = QuizExcerciseViewModel(widget.model);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
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
                  selectedAnswer: viewModel.selectedAnswer,
                  isAnswerSelected: viewModel.isAnswerSelected,
                  onAnswerSelected: (val) =>
                      viewModel.handleOptionSelected(val, widget.onRequestNext),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShadButton(
                    onPressed: widget.onRequestNext,
                    icon: const Icon(
                      Icons.navigate_next,
                      size: 16,
                    ),
                    child: const Text('Next'),
                  ),
                  if (viewModel.isAnswerSelected && viewModel.countdown > 0)
                    Center(
                      child: Text(
                        'Next question in ${viewModel.countdown} seconds...',
                        style: ShadTheme.of(context).textTheme.muted,
                      ),
                    ),
                ],
              ),
            ],
          );
        });
  }
}
