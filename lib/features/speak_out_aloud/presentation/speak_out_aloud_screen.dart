import 'package:flutter/material.dart';

import 'package:practly/core/async/async_page.dart';
import 'package:practly/core/widgets/header.dart';
import 'package:practly/core/widgets/speak/speak_excercise_screen.dart';
import 'package:practly/core/services/text_to_speech_service.dart';
import 'package:practly/core/widgets/complexity_selector.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/buisness_logic/speak_out_aloud_notifier.dart';

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
            const Header(title: 'Speak Out Aloud'),
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
            Expanded(
              child: AnimatedBuilder(
                  animation: notifier,
                  builder: (context, child) {
                    return AsyncPage(
                      asyncValue: notifier.state,
                      onRetry: notifier.generateSentence,
                      dataBuilder: (model) => SpeakExcerciseScreen(
                        model: model,
                        onRequestNext: notifier.generateSentence,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
