import 'package:flutter/material.dart';
import 'package:practly/core/excercise_widgets/speak/speak_excercise_viewmodel.dart';
import 'package:practly/di/di.dart';
import 'package:practly/features/speak_out_aloud/data/speak_out_aloud_model.dart';
import 'package:practly/core/excercise_widgets/speak/score_display.dart';
import 'package:practly/core/excercise_widgets/speak/speak_out_aloud_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SpeakExcerciseScreen extends StatefulWidget {
  const SpeakExcerciseScreen({
    super.key,
    required this.model,
    required this.onRequestNext,
  });

  final SpeakOutAloudModel model;
  final Function() onRequestNext;

  @override
  State<SpeakExcerciseScreen> createState() => _SpeakExcerciseScreenState();
}

class _SpeakExcerciseScreenState extends State<SpeakExcerciseScreen> {
  late final SpeakExcerciseViewmodel viewmodel;

  @override
  void initState() {
    viewmodel = SpeakExcerciseViewmodel(
      widget.model,
      locator.get(),
      locator.get(),
      locator.get(),
    );
    super.initState();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: viewmodel,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SpeakOutAloudContent(
                  model: widget.model,
                  speechService: viewmodel.tts,
                  spokenWordsStream: viewmodel.stt.spokenWords,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShadButton.outline(
                      size: ShadButtonSize.lg,
                      icon: const Icon(Icons.mic),
                      enabled: viewmodel.enableSpeechButton,
                      onPressed: viewmodel.listen,
                    ),
                    ScoreDisplay(score: viewmodel.score),
                    if (viewmodel.score > 5)
                      ShadButton.outline(
                        size: ShadButtonSize.lg,
                        icon: const Icon(Icons.navigate_next_sharp),
                        enabled: viewmodel.enableSpeechButton,
                        onPressed: () async {
                          viewmodel.onError();
                          widget.onRequestNext();
                        },
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          );
        });
  }
}
