import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ForgotPasswordEndpoint extends Endpoint {
  final ForgotPasswordInput input;

  ForgotPasswordEndpoint(this.input);

  @override
  String get route => ApiRoutes.forgotPassword;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class ForgotPasswordInput {
  final String email;

  ForgotPasswordInput({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
    };
  }
}
