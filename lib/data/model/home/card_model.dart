class CardModel {
  int? totalCount;
  int? masteredCount;
  int? learningCount;

  CardModel({
    this.totalCount,
    this.masteredCount,
    this.learningCount,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        totalCount: json["totalCount"],
        masteredCount: json["masteredCount"],
        learningCount: json["learningCount"],
      );
}
