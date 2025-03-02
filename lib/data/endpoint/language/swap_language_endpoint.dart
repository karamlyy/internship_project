import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class SwapLanguageEndpoint extends Endpoint {
  final int id;

  SwapLanguageEndpoint({
    required this.id,
  });

  @override
  String get route => '${ApiRoutes.swapLanguagePair}/$id';

  @override
  HttpMethod get httpMethod => HttpMethod.post;
}
