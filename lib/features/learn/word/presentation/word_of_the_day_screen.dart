import 'package:flutter/material.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/learn/word/buisness_logic/word_of_the_day_notifier.dart';
import 'package:practly/features/learn/word/presentation/word_of_the_day_content.dart';

class WordOfTheDayScreen extends StatefulWidget {
  const WordOfTheDayScreen({super.key});

  @override
  State<WordOfTheDayScreen> createState() => _WordOfTheDayScreenState();
}

class _WordOfTheDayScreenState extends State<WordOfTheDayScreen>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: 'Word of the day'),
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
                  onRefresh: () => notifier.generateWord(forceRemote: true),
                );
              },
              onRetry: notifier.generateWord,
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
