import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class GetAllLearningWordsEndpoint extends Endpoint {


  @override
  String get route => ApiRoutes.getAllLearningWords;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

}
