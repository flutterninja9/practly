class OutOfGenerationCredits implements Exception {
  @override
  String toString() {
    return "Oops! you ran out of credits. Please watch a short ad to gain some.";
  }
}
