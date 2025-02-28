import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ChangePasswordEndpoint extends Endpoint {
  final ChangePasswordInput input;

  ChangePasswordEndpoint(this.input);

  @override
  String get route => ApiRoutes.changePassword;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class ChangePasswordInput {
  final String currentPassword;
  final String newPassword;

  ChangePasswordInput({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };
  }
}
