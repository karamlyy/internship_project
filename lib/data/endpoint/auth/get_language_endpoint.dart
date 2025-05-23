import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class GetLanguageEndpoint extends Endpoint {
  @override
  String get route => ApiRoutes.getAllLanguages;

  @override
  HttpMethod get httpMethod => HttpMethod.get;
}
