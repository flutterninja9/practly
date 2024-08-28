import 'package:flutter/material.dart';
import 'package:practly/core/widgets/highlighted_section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/speakable.dart';
import 'package:practly/features/word_of_the_day/data/word_of_the_day_model.dart';

class WordOfTheDayContent extends StatelessWidget {
  const WordOfTheDayContent({
    super.key,
    required this.model,
    required this.speechService,
  });

  final WordOfTheDayModel model;
  final TextToSpeechService speechService;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ShadCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpeakableText(tts: speechService, sentence: model.word),
            const SizedBox(height: 10),
            Text(
              model.definition,
              style: ShadTheme.of(context).textTheme.small,
            ),
            const SizedBox(height: 20),
            HighlightedSection(title: "Example:", content: model.example),
            const SizedBox(height: 20),
            HighlightedSection(title: "Usage:", content: model.usage),
          ],
        ),
      ),
    );
  }
}
