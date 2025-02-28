import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class AddToMasterEndpoint extends Endpoint {
  final int id;
  final bool? addToLearning;

  AddToMasterEndpoint({
    required this.id,
    this.addToLearning = false,
  });

  @override
  String get route => '${ApiRoutes.addToMaster}$id';

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {
    'addToLearning': addToLearning,
  };
}
