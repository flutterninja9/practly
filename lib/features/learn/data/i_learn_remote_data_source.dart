import 'package:practly/core/enums/enums.dart';
import 'package:practly/features/learn/data/daily_dialogs_model.dart';
import 'package:practly/features/learn/data/word_of_the_day_model.dart';

abstract class ILearnRemoteDataSource {
  String prompt(WordComplexity complexity) => '''
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

  Future<WordOfTheDayModel> generateWordOfTheDay({
    WordComplexity complexity = WordComplexity.easy,
  });

  Future<List<DailyDialogModel>> getDailyDialogs({
    WordComplexity complexity = WordComplexity.easy,
  });
}
