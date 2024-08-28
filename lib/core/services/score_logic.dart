import 'dart:math';

import 'package:practly/core/extensions/string_extensions.dart';

class ScoreLogic {
  int calculateScore(String correctSentence, String userSentence) {
    int distance = _levenshteinDistance(
      correctSentence.normalized.toLowerCase(),
      userSentence.toLowerCase(),
    );

    int maxLength = max(correctSentence.length, userSentence.length);

    // Calculate a normalized score (0.0 to 1.0)
    double normalizedScore = (1.0 - distance / maxLength);

    // Map normalized score to a score between 1 and 10
    int score = (normalizedScore * 9 + 1).round();

    return score;
  }

// Function to calculate Levenshtein distance
  int _levenshteinDistance(String s1, String s2) {
    List<List<int>> dp =
        List.generate(s2.length + 1, (_) => List<int>.filled(s1.length + 1, 0));

    for (int i = 0; i <= s2.length; i++) {
      for (int j = 0; j <= s1.length; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (s2[i - 1] == s1[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 + min(dp[i - 1][j - 1], min(dp[i - 1][j], dp[i][j - 1]));
        }
      }
    }

    return dp[s2.length][s1.length];
  }
}
