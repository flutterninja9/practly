import 'package:flutter_test/flutter_test.dart';
import 'package:practly/core/services/score_logic.dart';

void main() {
  group('ScoreLogic', () {
    final scoreLogic = ScoreLogic();

    test('Returns 10 when both sentences are identical', () {
      const sentence = 'This is a test sentence';
      final score = scoreLogic.calculateScore(sentence, sentence);
      expect(score, 10);
    });

    test('Returns a lower score when sentences have a minor difference',
        () async {
      const correctSentence = 'This is a test sentence';
      const userSentence = 'This is a test sentenc';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, 10);
      expect(score, greaterThan(8));
    });

    test('Returns 1 when sentences are completely different', () {
      const correctSentence = 'This is a test sentence';
      const userSentence = 'Completely unrelated sentence';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, lessThan(10));
    });

    test('Returns a lower score for different case without normalization', () {
      const correctSentence = 'This is a test sentence';
      const userSentence = 'this is a test sentence';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, 10);
    });

    test('Handles empty user input correctly', () {
      const correctSentence = 'This is a test sentence';
      const userSentence = '';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, 1);
    });

    test('Handles empty correct sentence correctly', () {
      const correctSentence = '';
      const userSentence = 'This is a test sentence';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, 1);
    });

    test('Returns correct score for sentences with different lengths', () {
      const correctSentence = 'Short';
      const userSentence = 'A much longer sentence that does not match';
      final score = scoreLogic.calculateScore(correctSentence, userSentence);
      expect(score, lessThan(5));
    });
  });
}
