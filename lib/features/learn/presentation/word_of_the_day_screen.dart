import 'package:flutter/material.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/buisness_logic/word_of_the_day_notifier.dart';
import 'package:practly/features/learn/presentation/word_of_the_day_content.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: 'Word of the Day'),
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
        AnimatedBuilder(
          animation: notifier,
          builder: (context, child) {
            return AsyncPage(
              asyncValue: notifier.state,
              dataBuilder: (model) {
                return WordOfTheDayContent(
                  model: model,
                  speechService: speechService,
                  onRefresh: notifier.generateWord,
                );
              },
              onRetry: notifier.generateWord,
            );
          },
        ),
      ],
    );
  }
}
