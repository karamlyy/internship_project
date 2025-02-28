class CategoryModel {
  int id;
  String name;
  String image;
  int masteredCount;
  int vocabularyCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.masteredCount,
    required this.vocabularyCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      masteredCount: json["masteredCount"],
      vocabularyCount: json["vocabularyCount"],
    );
  }
}
