import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ResetPasswordEndpoint extends Endpoint {
  final ResetPasswordInput input;

  ResetPasswordEndpoint(this.input);

  @override
  String get route => ApiRoutes.resetPassword;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();

}

class ResetPasswordInput {
  final String userId;
  final String newPassword;

  ResetPasswordInput({
    required this.userId,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "newPassword": newPassword,
    };
  }
}
