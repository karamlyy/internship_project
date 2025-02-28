import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class AddToLearningEndpoint extends Endpoint {
  final int id;

  AddToLearningEndpoint({
    required this.id,
  });

  @override
  String get route => '${ApiRoutes.addToLearning}$id';

  @override
  HttpMethod get httpMethod => HttpMethod.post;
}
