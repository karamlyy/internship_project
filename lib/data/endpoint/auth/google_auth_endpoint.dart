import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class GoogleAuthEndpoint extends Endpoint {
  final String idToken;

  GoogleAuthEndpoint(this.idToken);

  @override
  String get route => ApiRoutes.googleAuth;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic> get body => {"idToken": idToken};
}
