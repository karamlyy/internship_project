import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class QuizEndpoint extends Endpoint {
  final List<int> excludeIds;
  final bool? isMastered;

  QuizEndpoint({required this.excludeIds, this.isMastered});

  @override
  String get route => ApiRoutes.getQuizQuestion;

  @override
  HttpMethod get httpMethod => HttpMethod.get;

  @override
  Map<String, dynamic>? get queryParameters {
    final params = <String, dynamic>{};

    if (excludeIds.isNotEmpty) {
      params['excludeIds'] = excludeIds.map((id) => id.toString()).toList();
    }

    if (isMastered != null) {
      params['isMastered'] = isMastered.toString();
    }

    return params.isNotEmpty ? params : null;
  }
}
