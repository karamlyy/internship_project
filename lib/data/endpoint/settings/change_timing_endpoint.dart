import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class ChangeTimingEndpoint extends Endpoint {
  final ChangeTimingInput input;

  ChangeTimingEndpoint(this.input);

  @override
  String get route => ApiRoutes.changeNotificationSettings;

  @override
  HttpMethod get httpMethod => HttpMethod.put;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class ChangeTimingInput {
  final int? intervalId;
  final DateTime? startTime;
  final DateTime? endTime;

  ChangeTimingInput({
    this.intervalId,
    this.startTime,
    this.endTime,
  });

  Map<String, dynamic> toJson() => {
    'intervalId': intervalId,
    'startTime': startTime?.toUtc().toIso8601String(),
    'endTime': endTime?.toUtc().toIso8601String(),
  };

  factory ChangeTimingInput.fromJson(Map<String, dynamic> json) {
    return ChangeTimingInput(
      intervalId: json["intervalId"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
    );
  }
}
