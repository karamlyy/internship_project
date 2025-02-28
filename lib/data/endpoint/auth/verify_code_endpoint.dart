import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class VerifyCodeEndpoint extends Endpoint {
  final VerifyCodeInput input;

  VerifyCodeEndpoint(this.input);

  @override
  String get route => ApiRoutes.verifyCode;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();

}

class VerifyCodeInput {
  final String userId;
  final String code;

  VerifyCodeInput({
    required this.userId,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "code": code,
    };
  }
}
