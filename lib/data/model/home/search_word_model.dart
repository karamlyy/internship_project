class SearchWordModel {
  int id;
  String? sourceLanguage;
  String? translationLanguage;
  bool? isMastered;
  bool? isLearningNow;

  SearchWordModel({
    required this.id,
    this.sourceLanguage,
    this.translationLanguage,
    this.isMastered,
    this.isLearningNow,
  });

  factory SearchWordModel.fromJson(Map<String, dynamic> json) {
    return SearchWordModel(
      id: json["id"] ?? 0,
      sourceLanguage: json["sourceLanguage"],
      translationLanguage: json["translationLanguage"],
      isMastered: json["isMastered"],
      isLearningNow: json["isLearningNow"]
    );
  }
}
