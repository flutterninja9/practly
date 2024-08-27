import 'package:get_it/get_it.dart';
import 'package:practly/di/setup_core.dart';
import 'package:practly/di/setup_quiz.dart';
import 'package:practly/di/setup_speak_out_aloud.dart';
import 'package:practly/di/setup_word_of_the_day.dart';

final locator = GetIt.I;

Future<void> initializeDeps() async {
  await setupCore();
  setupWordOfTheDay();
  setupSpeakOutAloud();
  setupQuiz();
}
