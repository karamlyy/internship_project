import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class GetAllWordsEndpoint extends Endpoint {
  final int page;
  final int pageSize;

  GetAllWordsEndpoint({
    required this.page,
    required this.pageSize,
  });

  @override
  String get route => ApiRoutes.getAllWords;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters => {
    'page': page,
    'pageSize': pageSize,
  };
}


class GetAllWordsListEndpoint extends Endpoint {


  @override
  String get route => ApiRoutes.getAllWordsList;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

}
