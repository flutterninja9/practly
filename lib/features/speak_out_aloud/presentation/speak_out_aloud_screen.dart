import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/buisness_logic/speak_out_aloud_notifier.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

class SpeakOutAloudScreen extends StatefulWidget {
  const SpeakOutAloudScreen({super.key});

  @override
  State<SpeakOutAloudScreen> createState() => _SpeakOutAloudScreenState();
}

class _SpeakOutAloudScreenState extends State<SpeakOutAloudScreen> {
  late final SpeakOutAloudNotifier notifier;
  late final FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    notifier = locator.get();
    notifier.generateSentence();
    _flutterTts = FlutterTts();
  }

  Future<void> _speakSentence(String sentence) async {
    await _flutterTts.speak(sentence);
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
              'Speak Out Aloud',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildComplexitySelector(),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedBuilder(
                animation: notifier,
                builder: (context, child) {
                  return AsyncPage(
                    asyncValue: notifier.state,
                    dataBuilder: _buildSentenceContent,
                    onRetry: notifier.generateSentence,
                  );
                },
              ),
            ),
            AnimatedBuilder(
                animation: notifier,
                builder: (context, child) {
                  return AsyncPage(
                    asyncValue: notifier.state,
                    errorBuilder: () => const SizedBox.shrink(),
                    loadingBuilder: () => const SizedBox.shrink(),
                    dataBuilder: (model) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: notifier.generateSentence,
                            child: const Text('Generate New Sentence'),
                          ),
                          ElevatedButton(
                            onPressed: () => _speakSentence(model.sentence),
                            child: const Text('Hear Sentence'),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildComplexitySelector() {
    return AnimatedBuilder(
        animation: notifier,
        builder: (context, child) {
          return SegmentedButton<WordComplexity>(
            segments: const [
              ButtonSegment(value: WordComplexity.easy, label: Text('Easy')),
              ButtonSegment(
                  value: WordComplexity.medium, label: Text('Medium')),
              ButtonSegment(value: WordComplexity.hard, label: Text('Hard')),
            ],
            selected: {notifier.complexity},
            onSelectionChanged: (Set<WordComplexity> newSelection) {
              notifier.setComplexity(newSelection.first);
              notifier.generateSentence();
            },
          );
        });
  }

  Widget _buildSentenceContent(SpeakOutAloudModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                model.sentence,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Explanation:',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(model.explanation),
          const SizedBox(height: 20),
          Text(
            'Pronunciation Tip:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(model.tip),
        ],
      ),
    );
  }
}
