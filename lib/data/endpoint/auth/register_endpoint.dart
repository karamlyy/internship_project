import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class RegisterEndpoint extends Endpoint {
  final RegisterInput input;

  RegisterEndpoint(this.input);

  @override
  String get route => ApiRoutes.register;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();


}

class RegisterInput {
  final String email;
  final String password;

  RegisterInput({
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
