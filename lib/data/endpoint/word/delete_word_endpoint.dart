import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class DeleteWordEndpoint extends Endpoint {
  final int id;

  DeleteWordEndpoint({
    required this.id,
  });

  @override
  String get route => '${ApiRoutes.deleteWord}/$id';

  @override
  HttpMethod get httpMethod => HttpMethod.delete;
}
