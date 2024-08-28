import 'package:flutter/material.dart';
import 'package:practly/features/word_of_the_day/presentation/word_of_the_day_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/word_of_the_day/buisness_logic/word_of_the_day_notifier.dart';

class WordOfTheDayScreen extends StatefulWidget {
  const WordOfTheDayScreen({super.key});

  @override
  State<WordOfTheDayScreen> createState() => _WordOfTheDayScreenState();
}

class _WordOfTheDayScreenState extends State<WordOfTheDayScreen>
    with SingleTickerProviderStateMixin {
  late final WordOfTheDayNotifier notifier;
  late final TextToSpeechService speechService;

  @override
  void initState() {
    super.initState();
    notifier = locator.get<WordOfTheDayNotifier>();
    notifier.generateWord();
    speechService = locator.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Word of the Day',
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
                      notifier.generateWord();
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
                        dataBuilder: (model) {
                          return WordOfTheDayContent(
                            model: model,
                            speechService: speechService,
                          );
                        },
                        onRetry: notifier.generateWord,
                      );
                    }),
              ),
              AnimatedBuilder(
                  animation: notifier,
                  builder: (context, child) {
                    return AsyncPage(
                      asyncValue: notifier.state,
                      loadingBuilder: () => const SizedBox.shrink(),
                      errorBuilder: () => const SizedBox.shrink(),
                      dataBuilder: (model) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShadButton(
                              onPressed: notifier.generateWord,
                              icon: const Icon(
                                Icons.navigate_next,
                                size: 16,
                              ),
                              child: const Text('Next word'),
                            )
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
