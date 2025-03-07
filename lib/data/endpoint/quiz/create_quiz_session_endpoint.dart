import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class CreateQuizSessionEndpoint extends Endpoint {
  final CreateQuizSessionInput input;

  CreateQuizSessionEndpoint(this.input);

  @override
  String get route => ApiRoutes.quizSession;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class CreateQuizSessionInput {
  final int correctAnswers;
  final int totalQuestions;
  final int remainingHealth;
  final DateTime quizDate;

  CreateQuizSessionInput({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.remainingHealth,
    required this.quizDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "correctAnswers": correctAnswers,
      "totalQuestions": totalQuestions,
      "remainingHealth": remainingHealth,
      "quizDate": quizDate.toIso8601String(),
    };
  }
}
