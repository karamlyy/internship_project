import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ExportDownloadEndpoint extends Endpoint {
  final List<int> masteredIds;


  ExportDownloadEndpoint({required this.masteredIds,});

  @override
  String get route => ApiRoutes.exportWords;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters {
    final params = <String, dynamic>{};
    if (masteredIds.isNotEmpty) {
      params['masteredIds'] = masteredIds.map((id) => id.toString()).toList();
    }
    return params.isNotEmpty ? params : null;
  }
}
