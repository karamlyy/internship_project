import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class LoginEndpoint extends Endpoint {
  final LoginInput input;

  LoginEndpoint(this.input);

  @override
  String get route => ApiRoutes.login;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
