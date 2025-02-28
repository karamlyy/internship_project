import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class NewWordEndpoint extends Endpoint {
  final NewWordInput input;

  NewWordEndpoint(this.input);

  @override
  String get route => ApiRoutes.newWord;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class NewWordInput {
  final String source;
  final String translation;
  final bool isLearningNow;

  NewWordInput({
    required this.source,
    required this.translation,
    required this.isLearningNow,
  });

  Map<String, dynamic> toJson() {
    return {
      "source": source,
      "translation": translation,
      "isLearningNow": isLearningNow,
    };
  }
}
