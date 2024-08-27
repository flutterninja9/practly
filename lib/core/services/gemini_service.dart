import 'package:google_gemini/google_gemini.dart';
import 'package:practly/core/enums/enums.dart';

class GenerationService {
  final GoogleGemini _gemini;

  GenerationService(this._gemini);

  String _promptForWOTD(WordComplexity complexity) => '''
  You are a helpful language learning assistant. Your task is to generate a random word to improve the user's vocabulary based on the given complexity level: {complexity} (easy/medium/hard).

  Generate a random word appropriate for the ${complexity.name} level.
  Provide a clear, concise definition of the word.
  Use the word in a simple example sentence.
  Offer a brief explanation of how the word is commonly used or any notable connotations.

  Remember:

  For "easy" words, use common, everyday vocabulary suitable for beginners.
  For "medium" words, use more advanced vocabulary that an intermediate learner might encounter.
  For "hard" words, use sophisticated or specialized vocabulary that would challenge advanced learners.

  Output Format:

    {
    "word": "[Generated word]",
    "definition": "[Clear, concise definition]",
    "example": "[Sentence using the word]",
    "usage": "[Brief explanation of common usage or connotations]"
    }

    Ensure that any double quotes inside the sentence, explanation, or tip are properly escaped with a backslash (\\) to make the JSON valid.

    Here is an example of a properly formatted JSON response:
      {
  "word": "Quaint",
  "definition": "Pleasingly old-fashioned",
  "example": "The quaint little cottage was a welcome sight after a long day of travel.",
  "usage": "Quaint is often used to describe things that are charming or nostalgic, especially buildings, towns, or objects that evoke a sense of the past."
}

    Please ensure that the JSON you provide is well-formed and safe to parse in a programming environment.
''';

  String _promptForSentence(WordComplexity complexity) => '''
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

  String _promptForQuiz(WordComplexity complexity) => '''
  You are a english grammer teacher with over 20+ years of experience. Every student you have taught is also a master of english language now.
  Generate a ${complexity.name} grammar or vocabulary-focused quiz question with a sentence that contains a blank space to fill in. Provide four multiple-choice options, including the correct answer. The sentence should test the user's understanding of word usage, verb forms, prepositions, or other grammatical concepts. Ensure the difficulty level is set according to the specified level. Remember: Do not hallucinate or generate wrong option as this is a reputable app which many students are going to use to learn english.

  Difficulty Level: [easy/medium/hard]

  Output Format:

  {
    "sentence": "She is looking forward to ____ her vacation.",
    "options": {
      "a": "start",
      "b": "starting",
      "c": "started",
      "d": "starts"
    },
    "correct_answer": "b"
  }
  ''';

  Future<String> generateWordOfTheDay({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    final res = await _gemini.generateFromText(_promptForWOTD(complexity));
    return res.text;
  }

  Future<String> generateSentence({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    final res = await _gemini.generateFromText(_promptForSentence(complexity));
    return res.text;
  }

  Future<String> generateQuiz({
    WordComplexity complexity = WordComplexity.easy,
  }) async {
    final res = await _gemini.generateFromText(_promptForQuiz(complexity));
    return res.text;
  }
}
