class PersonalRecordModel {
  int averageQuestionsPerQuiz;
  int correctAnswerRecord;

  PersonalRecordModel({
    required this.averageQuestionsPerQuiz,
    required this.correctAnswerRecord,
  });

  factory PersonalRecordModel.fromJson(Map<String, dynamic> json) {
    return PersonalRecordModel(
      averageQuestionsPerQuiz: json["averageQuestionsPerQuiz"],
      correctAnswerRecord: json["correctAnswerRecord"],
    );
  }
}
