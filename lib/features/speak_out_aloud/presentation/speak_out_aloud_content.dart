import 'package:flutter/material.dart';
import 'package:practly/core/extensions/string_extensions.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';

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

  List<InlineSpan> _richSentence(
    BuildContext context,
    List<String> spokenWords,
  ) {
    return model.sentence.split(" ").map((word) {
      String normalizedWord = word.normalized.toLowerCase();

      return TextSpan(
        text: "$word ",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: spokenWords.contains(normalizedWord)
                  ? Colors.green
                  : Colors.black,
            ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              await speechService.speak(model.sentence);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<String>(
                    stream: spokenWordsStream,
                    builder: (context, snapshot) {
                      return RichText(
                        text: TextSpan(
                          children: [
                            ..._richSentence(
                                context, snapshot.data?.split(" ") ?? []),
                            const WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.volume_up,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
