import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/enums/enums.dart';
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
  late final WordOfTheDayNotifier _wotdNotifier;
  late final FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    _wotdNotifier = locator.get<WordOfTheDayNotifier>();
    _wotdNotifier.generateWord();
    _flutterTts = FlutterTts();
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
              _buildComplexitySelector(),
              const SizedBox(height: 20),
              Expanded(
                child: AnimatedBuilder(
                    animation: _wotdNotifier,
                    builder: (context, child) {
                      return AsyncPage(
                        asyncValue: _wotdNotifier.state,
                        dataBuilder: _buildWordContent,
                        onRetry: _wotdNotifier.generateWord,
                      );
                    }),
              ),
              AnimatedBuilder(
                  animation: _wotdNotifier,
                  builder: (context, child) {
                    return AsyncPage(
                      asyncValue: _wotdNotifier.state,
                      loadingBuilder: () => const SizedBox.shrink(),
                      errorBuilder: () => const SizedBox.shrink(),
                      dataBuilder: (model) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: _wotdNotifier.generateWord,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                              child: const Text('Generate New Word'),
                            ),
                            ElevatedButton(
                              onPressed: () => _speakWord(model.word),
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

  Future<void> _speakWord(String word) async {
    await _flutterTts.speak(word);
  }

  Widget _buildComplexitySelector() {
    return AnimatedBuilder(
        animation: _wotdNotifier,
        builder: (context, child) {
          return SegmentedButton<WordComplexity>(
            segments: const [
              ButtonSegment(value: WordComplexity.easy, label: Text('Easy')),
              ButtonSegment(
                  value: WordComplexity.medium, label: Text('Medium')),
              ButtonSegment(value: WordComplexity.hard, label: Text('Hard')),
            ],
            selected: {_wotdNotifier.complexity},
            onSelectionChanged: (Set<WordComplexity> newSelection) {
              _wotdNotifier.setComplexity(newSelection.first);
              _wotdNotifier.generateWord();
            },
          );
        });
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
