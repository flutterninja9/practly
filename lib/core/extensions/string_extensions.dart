extension Stringx on String {
  /// Normalize the word by removing common punctuation and special characters
  String get normalized => replaceAll(
          RegExp(r'[^\w\s]'), '') // Remove general punctuation marks
      .replaceAll(RegExp(r'[’‘“”"\-]'), '') // Handle curly quotes and dashes
      .replaceAll("'", '') // Handle straight apostrophes
      .replaceAll(RegExp(r'[àáâäãåą]'), 'a') // Normalize accented characters
      .replaceAll(RegExp(r'[çćč]'), 'c')
      .replaceAll(RegExp(r'[èéêëę]'), 'e')
      .replaceAll(RegExp(r'[ìíîï]'), 'i')
      .replaceAll(RegExp(r'[ł]'), 'l')
      .replaceAll(RegExp(r'[ñń]'), 'n')
      .replaceAll(RegExp(r'[òóôöõ]'), 'o')
      .replaceAll(RegExp(r'[ùúûü]'), 'u')
      .replaceAll(RegExp(r'[ýÿ]'), 'y')
      .replaceAll(RegExp(r'[żźž]'), 'z')
      .replaceAll(RegExp(r'[ß]'), 'ss') // Handle German 'ß' as 'ss'
      .replaceAll(RegExp(r'[æ]'), 'ae') // Handle 'æ' as 'ae'
      .replaceAll(RegExp(r'[œ]'), 'oe') // Handle 'œ' as 'oe'
      .replaceAll(
          RegExp(r'[\u200B-\u200D\uFEFF]'), ''); // Remove zero-width characters

  String capitalize() {
    if (isEmpty) return this; // Return the original string if empty
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
