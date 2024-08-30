import 'package:flutter/material.dart';

import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/buisness_logic/speak_out_aloud_notifier.dart';
import 'package:practly/features/speak_out_aloud/presentation/score_display.dart';
import 'package:practly/features/speak_out_aloud/presentation/speak_out_aloud_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpeakOutAloudScreen extends StatefulWidget {
  const SpeakOutAloudScreen({super.key});

  static String get route => "/speak";

  @override
  State<SpeakOutAloudScreen> createState() => _SpeakOutAloudScreenState();
}

class _SpeakOutAloudScreenState extends State<SpeakOutAloudScreen> {
  late final SpeakOutAloudNotifier notifier;
  late final TextToSpeechService speechService;

  @override
  void initState() {
    super.initState();
    notifier = locator.get();
    notifier.generateSentence();
    speechService = locator.get();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
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
              style: ShadTheme.of(context).textTheme.h1,
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: notifier,
              builder: (context, child) {
                return ComplexitySelector(
                  initialValue: notifier.complexity,
                  onChanged: (val) {
                    notifier.setComplexity(val);
                    notifier.generateSentence();
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
                    dataBuilder: (model) => SpeakOutAloudContent(
                      model: model,
                      speechService: speechService,
                      spokenWordsStream: notifier.stt.spokenWords,
                    ),
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
                      final enableButton = notifier.enableSpeechButton;

                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShadButton.outline(
                              size: ShadButtonSize.lg,
                              icon: const Icon(Icons.mic),
                              enabled: enableButton,
                              onPressed: () {
                                notifier.listen();
                              },
                            ),
                            ScoreDisplay(score: notifier.score),
                            if (notifier.score > 5)
                              ShadButton.outline(
                                size: ShadButtonSize.lg,
                                icon: const Icon(Icons.navigate_next_sharp),
                                enabled: enableButton,
                                onPressed: () async {
                                  notifier.onError();
                                  notifier.generateSentence();
                                },
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
