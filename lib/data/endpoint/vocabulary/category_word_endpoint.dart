import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class CategoryWordEndpoint extends Endpoint {
  final int vocabularyId;

  CategoryWordEndpoint(this.vocabularyId);

  @override
  String get route => ApiRoutes.addFromCategoryToLearning;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => {
    "vocabularyId": vocabularyId,
  };
}


