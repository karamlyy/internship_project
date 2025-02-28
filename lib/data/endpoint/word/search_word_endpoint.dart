import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class SearchWordEndpoint extends Endpoint {
  final String searchText;
  final int page;
  final int pageSize;

  SearchWordEndpoint({
    required this.searchText,
    required this.page,
    required this.pageSize,
  });

  @override
  String get route => ApiRoutes.searchWord;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters => {
        'searchText': searchText,
        'page': page,
        'pageSize': pageSize,
      };
}
