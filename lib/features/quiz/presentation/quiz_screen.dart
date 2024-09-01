import 'package:flutter/material.dart';
import 'package:practly/core/excercise_widgets/quiz/quiz_excercise_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/business_logic/quiz_notifier.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  static String get route => "/quiz";

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier = locator.get();
    notifier.generateQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz',
              style: ShadTheme.of(context).textTheme.h1,
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: notifier,
              builder: (context, child) {
                return ComplexitySelector(
                  initialValue: notifier.complexity,
                  onChanged: (val) {
                    notifier.setComplexity(val);
                    notifier.generateQuiz();
                  },
                );
              },
            ),
            Expanded(
              child: AnimatedBuilder(
                  animation: notifier,
                  builder: (context, child) {
                    return AsyncPage(
                      asyncValue: notifier.state,
                      onRetry: notifier.generateQuiz,
                      dataBuilder: (model) => QuizExcerciseScreen(
                        model: model,
                        onRequestNext: notifier.generateQuiz,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
