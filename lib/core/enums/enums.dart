enum Complexity {
  easy,
  medium,
  hard;

  static Complexity fromString(String val) {
    switch (val) {
      case 'easy':
        return Complexity.easy;
      case 'medium':
        return Complexity.medium;
      case 'hard':
        return Complexity.hard;
      default:
        throw UnsupportedError("$val is an invalid complexity type");
    }
  }
}
