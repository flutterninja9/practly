import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/models/excercise.dart';
import 'package:practly/features/learn/data/lesson_model.dart';
import 'package:practly/core/models/word/word_of_the_day_model.dart';

abstract class ILearnRemoteDataSource {
  String wordGenPrompt(Complexity complexity) => '''
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

  String excerciseGenPrompt(
    LessonModel lesson,
    Complexity complexity,
  ) =>
      '''
  Instruction: You will act as an English language teacher specializing in vocabulary and grammer improvement. 
I will provide you with a title, a description, and a difficulty level. The title and description will represent a real-life scenario. Your task is to generate 5 questions based on this information, following the exact format below:

Expected output format:

[
    {
        "type": "quiz",
        "sentence": "<Sentence with a blank>",
        "options": {
            "a": "<Option A>",
            "b": "<Option B>",
            "c": "<Option C>",
            "d": "<Option D>"
        },
        "correct_answer": "<Correct Option>"
    },
    {
        "type": "sentence",
        "sentence": "<Useful sentence that improves vocabulary>",
        "explanation": "<Explanation of why this sentence is useful>",
        "tip": "<Optional Tip to improve speaking or understanding>"
    }
]

If the question type is "sentence," include an "explanation" and an optional "tip." an it should not have any blanks like quiz.

Example:

Title: Grocery Shopping Description: You are at a grocery store for the first time. Difficulty: Easy

Expected Output:
[
    {
        "type": "quiz",
        "sentence": "I am accustomed ____ working in a team environment.",
        "options": {
            "a": "for",
            "b": "to",
            "c": "at",
            "d": "in"
        },
        "correct_answer": "b"
    },
    // ... 4 more questions
]

Please ensure that each question is relevant to the given scenario and that the difficulty level is appropriate.

Now here's the prompt: Generate something for me based on the above instructions where:

Title: ${lesson.title}
Description: ${lesson.description}
Difficulty: ${complexity.name}

''';

  Future<WordOfTheDayModel> generateWordOfTheDay({
    Complexity? complexity = Complexity.easy,
  });

  Future<List<LessonModel>> getLessons({
    Complexity complexity = Complexity.easy,
  });

  Future<List<Exercise>> getExercises({
    Complexity complexity = Complexity.easy,
    required LessonModel lesson,
  });
}
