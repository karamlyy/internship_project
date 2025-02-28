import 'package:language_learning/data/endpoint/base/endpoint.dart';
import 'package:language_learning/utils/api-route/api_routes.dart';

class TimingEndpoint extends Endpoint {
  final TimingInput input;

  TimingEndpoint(this.input);

  @override
  String get route => ApiRoutes.setUserTiming;

  @override
  HttpMethod get httpMethod => HttpMethod.post;

  @override
  Map<String, dynamic>? get body => input.toJson();
}

class TimingInput {
  final int? intervalId;
  final DateTime? startTime;
  final DateTime? endTime;

  TimingInput({
    required this.intervalId,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => {
        'intervalId': intervalId,
        'startTime': startTime?.toUtc().toIso8601String(),
        'endTime': endTime?.toUtc().toIso8601String(),
      };

  factory TimingInput.fromJson(Map<String, dynamic> json) {
    return TimingInput(
      intervalId: json["intervalId"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
    );
  }
}
