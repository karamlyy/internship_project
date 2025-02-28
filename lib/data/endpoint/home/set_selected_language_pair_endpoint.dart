import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class SetSelectedLanguagePairEndpoint extends Endpoint {
  final int id;

  SetSelectedLanguagePairEndpoint({
    required this.id,
  });

  @override
  String get route => '${ApiRoutes.setSelectedLanguagePair}$id';

  @override
  HttpMethod get httpMethod => HttpMethod.post;
}
