import 'package:flutter/material.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/word_of_the_day/buisness_logic/word_of_the_day_notifier.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';

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
                style: Theme.of(context).textTheme.headlineMedium,
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
                        dataBuilder: _buildWordContent,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: notifier.generateWord,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                              child: const Text('Generate New Word'),
                            ),
                            ElevatedButton(
                              onPressed: () => speechService.speak(model.word),
                              child: const Text('Hear Word'),
                            ),
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

  Widget _buildWordContent(WordOfTheDayModel model) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.word,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                model.definition,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'Example:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.blue[700]),
              ),
              Text(model.example,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),
              Text(
                'Usage:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.blue[700]),
              ),
              Text(model.usage, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
