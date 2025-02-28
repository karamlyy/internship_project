class CategoryWordModel {
  final int id;
  final String source;
  final String translation;
  final bool isAdded;

  CategoryWordModel({
    required this.id,
    required this.source,
    required this.translation,
    required this.isAdded,
  });

  factory CategoryWordModel.fromJson(Map<String, dynamic> json) {
    return CategoryWordModel(
      id: json['id'] ?? '',
      source: json['source'] ?? '',
      translation: json['translation'] ?? '',
      isAdded: json['isAdded'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'translation': translation,
      'isAdded': isAdded,
    };
  }
}
