import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ReportQuizEndpoint extends Endpoint {
  final int correctAnswerCount;

  ReportQuizEndpoint({
    required this.correctAnswerCount,
  });

  @override
  String get route => ApiRoutes.createQuizReport;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get queryParameters => {
        'correctAnswerCount': correctAnswerCount,
      };
}
