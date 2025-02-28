import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class CategoryVocabularyEndpoint extends Endpoint {
  final int categoryId;

  CategoryVocabularyEndpoint({
    required this.categoryId,
  });

  @override
  String get route => ApiRoutes.getAllCategoryVocabulary;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters => {
        'categoryId': categoryId,
      };
}
