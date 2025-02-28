class LanguageModel {
  int id;
  String? name;
  String? image;

  LanguageModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }
}
