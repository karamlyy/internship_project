class WordPairModel {
  final int id;
  final String source;
  final String translation;
  final bool? isMastered;
  final bool? isLearningNow;

  WordPairModel({
    required this.id,
    required this.source,
    required this.translation,
    this.isMastered,
    this.isLearningNow
  });

  factory WordPairModel.fromJson(Map<String, dynamic> json) {
    return WordPairModel(
      id: json['id'] ?? '',
      source: json['source'] ?? '',
      translation: json['translation'] ?? '',
      isMastered: json['isMastered'] ?? false,
      isLearningNow: json['isLearningNow'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'translation': translation,
      'isMastered': isMastered,
      'isLearningNow': isLearningNow,
    };
  }
  
}