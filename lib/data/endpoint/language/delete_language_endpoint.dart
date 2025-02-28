import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class DeleteLanguageEndpoint extends Endpoint {
  final int id;

  DeleteLanguageEndpoint({
    required this.id,
  });

  @override
  String get route => '${ApiRoutes.deleteLanguagePair}/$id';

  @override
  HttpMethod get httpMethod => HttpMethod.delete;
}
