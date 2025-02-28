class LanguagePairModel {
  int id;
  String sourceLanguage;
  String translationLanguage;
  bool isSelected;
  bool isSwapped;

  LanguagePairModel({
    required this.id,
    required this.sourceLanguage,
    required this.translationLanguage,
    required this.isSelected,
    required this.isSwapped,
  });

  factory LanguagePairModel.fromJson(Map<String, dynamic> json) {
    return LanguagePairModel(
      id: json["id"],
      sourceLanguage: json["sourceLanguage"],
      translationLanguage: json["translationLanguage"],
      isSelected: json["isSelected"],
      isSwapped: json["isSwapped"],
    );
  }
}
