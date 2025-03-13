import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ExportDownloadEndpoint extends Endpoint {
  final List<int> ids;


  ExportDownloadEndpoint({required this.ids,});

  @override
  String get route => ApiRoutes.exportWords;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters {
    final params = <String, dynamic>{};
    if (ids.isNotEmpty) {
      params['ids'] = ids.map((id) => id.toString()).toList();
    }
    return params.isNotEmpty ? params : null;
  }
}
