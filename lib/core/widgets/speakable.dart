import 'package:flutter/material.dart';
import 'package:practly/core/extensions/string_extensions.dart';

import 'package:practly/core/services/text_to_speech_service.dart';

class SpeakableText extends StatelessWidget {
  const SpeakableText({
    super.key,
    required this.tts,
    required this.sentence,
    this.delimeter = " ",
    this.spokenWords = "",
  });

  final TextToSpeechService tts;
  final String sentence;
  final String delimeter;
  final String spokenWords;

  List<InlineSpan> _richSentence(
    BuildContext context,
    List<String> spokenWords,
  ) {
    return sentence.split(" ").map((word) {
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
    return GestureDetector(
      onTap: () async {
        await tts.speak(sentence);
      },
      child: RichText(
        text: TextSpan(
          children: [
            ..._richSentence(context, spokenWords.split(delimeter)),
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
      ),
    );
  }
}
