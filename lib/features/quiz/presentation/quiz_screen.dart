import 'package:flutter/material.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/async/async_value.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/quiz/business_logic/quiz_notifier.dart';
import 'package:practly/features/quiz/data/quiz_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  void dispose() {
    notifier.dispose();
    super.dispose();
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
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: notifier,
                builder: (context, child) {
                  return AsyncPage(
                    asyncValue: notifier.state,
                    dataBuilder: _buildQuizContent,
                    onRetry: notifier.generateQuiz,
                  );
                },
              ),
            ),
            AnimatedBuilder(
                animation: notifier,
                builder: (context, child) {
                  final isLoading = notifier.state is Loading;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShadButton(
                        onPressed: isLoading ? null : notifier.generateQuiz,
                        icon: const Icon(
                          Icons.navigate_next,
                          size: 16,
                        ),
                        child: const Text('Next'),
                      ),
                      if (notifier.isAnswerSelected && notifier.countdown > 0)
                        Center(
                          child: Text(
                            'Next question in ${notifier.countdown} seconds...',
                            style: ShadTheme.of(context).textTheme.muted,
                          ),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizContent(QuizModel model) {
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
            final bool isSelected = notifier.selectedAnswer == entry.key;
            final bool isCorrect = entry.key == model.correctAnswer;
            final Color? tileColor = notifier.isAnswerSelected
                ? (isCorrect
                    ? const Color(0xFFA5D6A7)
                    : isSelected
                        ? const Color(0xFFEF9A9A)
                        : null)
                : null;

            return ListTile(
              title: Text(
                '${entry.key}) ${entry.value}',
                style: ShadTheme.of(context).textTheme.p,
              ),
              tileColor: tileColor,
              onTap: notifier.isAnswerSelected
                  ? null
                  : () => notifier.handleOptionSelected(entry.key),
            );
          }),
        ],
      ),
    );
  }
}
