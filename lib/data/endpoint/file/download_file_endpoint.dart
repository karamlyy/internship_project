import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class DownloadFileEndpoint extends Endpoint {
  @override
  String get route => 'https://github.com/karamlyy/db/blob/main/VocabularyTemplate.xlsx';

  @override
  HttpMethod get httpMethod => HttpMethod.get;
}
