import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/quiz/quiz_model.dart';

abstract class IQuizRemoteDataSource {
  String prompt(Complexity complexity) => '''
  You are an English grammar teacher with over 20+ years of experience. Every student you have taught is now a master of the English language.
  Generate a ${complexity.name} grammar or vocabulary-focused quiz question with a sentence that contains a blank space to fill in. Provide four multiple-choice options, including the correct answer. The sentence should test the user's understanding of word usage, verb forms, prepositions, or other grammatical concepts. Ensure the difficulty level is set according to the specified level. Remember: Do not hallucinate or generate wrong options as this is a reputable app which many students are going to use to learn English.

  Difficulty Level: ${complexity.name}

  Output Format:

  {
    "sentence": "She is looking forward to ____ her vacation.",
    "complexity": "${complexity.name}",
    "options": {
      "a": "start",
      "b": "starting",
      "c": "started",
      "d": "starts"
    },
    "correct_answer": "b"
  }
  ''';

  Future<QuizModel> generateQuiz({Complexity? complexity});
}
