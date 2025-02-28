import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class DeleteUserEndpoint extends Endpoint {
  @override
  String get route => ApiRoutes.deleteAccount;

  @override
  HttpMethod get httpMethod => HttpMethod.delete;
}
