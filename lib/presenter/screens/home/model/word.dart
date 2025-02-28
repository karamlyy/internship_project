class Word {
  final int id;
  final String word;
  final String translation;
  bool isLearned;

  Word({
    required this.id,
    required this.word,
    required this.translation,
    this.isLearned = false,
  });
}