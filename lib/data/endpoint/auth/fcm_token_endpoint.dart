import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class FcmTokenEndpoint extends Endpoint {
  final FcmTokenInput input;

  FcmTokenEndpoint(this.input);

  @override
  String get route => ApiRoutes.setFcmToken;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class FcmTokenInput {
  final String token;
  final String? timeZone;

  FcmTokenInput({
    required this.token,
    this.timeZone,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'timeZone': timeZone,
  };
}
