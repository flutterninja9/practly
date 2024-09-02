import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/speak/speak_out_aloud_model.dart';

abstract class ISentenceRemoteDataSource {
  String prompt(Complexity complexity) => '''
  You are a helpful language learning assistant. Your task is to generate a sentence for speaking practice based on the given complexity level: {complexity} (easy/medium/hard). The sentence should help users improve their pronunciation, fluency, and vocabulary.

  Generate a sentence appropriate for the ${complexity.name} level.
  Provide a brief explanation of any challenging words or phrases in the sentence.
  Offer a pronunciation tip for a word or sound in the sentence that might be difficult for language learners.

  Remember:

  For "easy" sentences, use common vocabulary and simple grammatical structures suitable for beginners.
  For "medium" sentences, incorporate more advanced vocabulary and grammatical structures that an intermediate learner might encounter.
  For "hard" sentences, use sophisticated vocabulary, idiomatic expressions, or complex grammatical structures that would challenge advanced learners.

  Ensure your explanations are clear and your pronunciation tips are helpful for language learners.
  Additional guidelines:

  Vary the topics of the sentences to cover a wide range of everyday situations and subjects.
  Include a mix of statement, question, and exclamation sentences across different generations.
  For medium and hard levels, occasionally include common idioms or colloquial expressions.
  Ensure that the sentences are natural and something a native speaker would likely say in conversation.

  Output Format:

  {
  "sentence": "[Generated Sentence]",
  "explanation": "[Brief explanation of any challenging words or phrases]",
  "tip": "[Tip for pronouncing a difficult word or sound]"
  }

  Ensure that any double quotes inside the sentence, explanation, or tip are properly escaped with a backslash (\\) to make the JSON valid.

  Here is an example of a properly formatted JSON response:
  {
    "sentence": "I'm going to the store to buy some milk.",
    "explanation": "This sentence is straightforward and uses common vocabulary. The only potentially challenging word is 'store,' which some learners may pronounce as 'stoah' instead of 'stawr.'",
    "tip": "To pronounce 'store' correctly, focus on making the 'aw' sound in the middle of the word, as in 'saw.'"
  }

  Please ensure that the JSON you provide is well-formed and safe to parse in a programming environment.
''';

  Future<SpeakOutAloudModel> generateSentence({
    Complexity complexity = Complexity.easy,
  });
}
