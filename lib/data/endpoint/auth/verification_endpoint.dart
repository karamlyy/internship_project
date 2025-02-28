import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class VerificationEndpoint extends Endpoint {
  final VerificationInput input;

  VerificationEndpoint(this.input);

  @override
  String get route => ApiRoutes.confirmEmail;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class ResendConfirmationEmail extends Endpoint {
  final String userId;

  ResendConfirmationEmail(
    this.userId,
  );

  @override
  String get route => ApiRoutes.resendConfirmationEmail;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => {
        "userId": userId,
      };
}

class VerificationInput {
  final String userId;
  final String? code;

  VerificationInput({
    required this.userId,
    this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "code": code,
    };
  }
}
