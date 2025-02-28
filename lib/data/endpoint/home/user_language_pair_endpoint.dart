import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class GetAllLanguagePairsEndpoint extends Endpoint {
  @override
  String get route => ApiRoutes.getUserLanguagePairs;

  @override
  HttpMethod get httpMethod => HttpMethod.get;
}
