import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class UpdateWordEndpoint extends Endpoint {
  final UpdateWordInput input;

  UpdateWordEndpoint(this.input);

  @override
  String get route => ApiRoutes.updateWord;

  @override
  HttpMethod get httpMethod => HttpMethod.put;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class UpdateWordInput {
  final int id;
  final String? source;
  final String? translation;

  UpdateWordInput({
    required this.id,
    this.source,
    this.translation,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "source": source,
      "translation": translation,

    };
  }
}
