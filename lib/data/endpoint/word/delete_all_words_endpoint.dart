import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class DeleteAllWordEndpoint extends Endpoint {
  @override
  String get route => ApiRoutes.deleteAllWords;

  @override
  HttpMethod get httpMethod => HttpMethod.delete;
}
