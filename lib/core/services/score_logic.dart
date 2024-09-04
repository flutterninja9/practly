import 'dart:math';
import 'package:practly/core/extensions/string_extensions.dart';

class ScoreLogic {
  int calculateScore(String correctSentence, String userSentence) {
    String normalizedCorrect = correctSentence.normalized.toLowerCase();
    String normalizedUser = userSentence.toLowerCase();

    if (normalizedCorrect == normalizedUser) {
      return 10;
    }

    int distance = _levenshteinDistance(normalizedCorrect, normalizedUser);
    int maxLength = max(normalizedCorrect.length, normalizedUser.length);

    double normalizedScore = (1.0 - distance / maxLength);

    return (normalizedScore * 9 + 1).round();
  }

  int _levenshteinDistance(String s1, String s2) {
    int len1 = s1.length;
    int len2 = s2.length;

    if (len1 == 0) return len2;
    if (len2 == 0) return len1;

    List<int> previousRow = List<int>.generate(len2 + 1, (index) => index);
    List<int> currentRow = List<int>.filled(len2 + 1, 0);

    for (int i = 1; i <= len1; i++) {
      currentRow[0] = i;
      for (int j = 1; j <= len2; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        currentRow[j] = min(
          min(currentRow[j - 1] + 1, previousRow[j] + 1),
          previousRow[j - 1] + cost,
        );
      }
      List<int> temp = previousRow;
      previousRow = currentRow;
      currentRow = temp;
    }

    return previousRow[len2];
  }
}
