import 'package:flutter/material.dart';
import 'package:practly/core/extensions/string_extensions.dart';
import 'package:practly/core/widgets/highlighted_section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/speakable.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';

class WordOfTheDayContent extends StatelessWidget {
  const WordOfTheDayContent({
    super.key,
    required this.model,
    required this.speechService,
    required this.onRefresh,
  });

  final WordOfTheDayModel model;
  final TextToSpeechService speechService;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: ShadTheme.of(context).cardTheme.padding?.copyWith(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: SpeakableText(
                  tts: speechService,
                  sentence: model.word,
                ),
              ),
              Row(
                children: [
                  ShadBadge.outline(
                    child: Text(model.complexity.name.capitalize()),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onRefresh,
                    child: const Icon(LucideIcons.refreshCcw, size: 20),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            model.definition,
            style: ShadTheme.of(context).textTheme.small,
          ),
          const SizedBox(height: 20),
          HighlightedSection(title: "Example:", content: model.example),
          const SizedBox(height: 20),
          HighlightedSection(title: "Usage:", content: model.usage),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
