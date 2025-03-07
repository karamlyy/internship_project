class QuestionModel {
  int? id;
  String? question;
  List<AnswerModel>? answers;
  bool? isHidden;
  bool? isListenable;

  QuestionModel({
    this.id,
    this.question,
    this.answers,
    this.isHidden,
    this.isListenable,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      return QuestionModel();
    }
    return QuestionModel(
      id: json['id'],
      question: json['question'],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isHidden: json['isHidden'],
      isListenable: json['isListenable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answers': answers?.map((e) => e.toJson()).toList(),
      'isHidden': isHidden,
      'isListenable': isListenable
    };
  }
}

class AnswerModel {
  String? source;
  String? answer;

  AnswerModel({this.source, this.answer});

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      source: json['source'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'answer': answer,
    };
  }
}
