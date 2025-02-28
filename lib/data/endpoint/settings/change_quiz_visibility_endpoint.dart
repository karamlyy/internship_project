import '../../../utils/api-route/api_routes.dart';
import '../base/endpoint.dart';

class ChangeQuizVisibilityEndpoint extends Endpoint {

  @override
  String get route => ApiRoutes.changeQuizVisibility;

  @override
  HttpMethod get httpMethod => HttpMethod.post;
}