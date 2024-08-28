import 'package:flutter/material.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/highlighted_section.dart';
import 'package:practly/core/widgets/speakable.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpeakOutAloudContent extends StatelessWidget {
  const SpeakOutAloudContent({
    super.key,
    required this.model,
    required this.spokenWordsStream,
    required this.speechService,
  });

  final SpeakOutAloudModel model;
  final Stream<String> spokenWordsStream;
  final TextToSpeechService speechService;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadCard(
            padding: const EdgeInsets.all(18),
            child: StreamBuilder<String>(
              stream: spokenWordsStream,
              builder: (context, snapshot) {
                return SpeakableText(
                  tts: speechService,
                  sentence: model.sentence,
                  spokenWords: snapshot.data ?? "",
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          HighlightedSection(title: "Explanation:", content: model.explanation),
          const SizedBox(height: 20),
          HighlightedSection(title: "Pronunciation Tip:", content: model.tip),
        ],
      ),
    );
  }
}
