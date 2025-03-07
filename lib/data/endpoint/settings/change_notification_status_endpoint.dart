import '../../../utils/api-route/api_routes.dart';
import '../base/endpoint.dart';

class ChangeNotificationStatusEndpoint extends Endpoint {

  @override
  String get route => ApiRoutes.changeNotificationStatus;

  @override
  HttpMethod get httpMethod => HttpMethod.post;
}