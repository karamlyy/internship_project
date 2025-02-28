import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/auth/fcm_token_endpoint.dart';
import 'package:language_learning/data/endpoint/auth/get_intervals_endpoint.dart';
import 'package:language_learning/data/endpoint/auth/get_language_endpoint.dart';
import 'package:language_learning/data/endpoint/auth/timing_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/language/language_model.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class UserConfigurationRepository {
  Future<Either<HttpException, List<LanguageModel>>> getAllLanguages();
  Future<Either<HttpException, List<TimeIntervalModel>>> getAllInterval();
  Future<Either<HttpException, void>> setTiming(TimingInput input);
  Future<Either<HttpException, void>> setFcmToken(FcmTokenInput input);
  Future<String?> getFcmToken();
}

class UserConfigurationRepositoryImpl extends UserConfigurationRepository {
  final ApiService apiService;

  UserConfigurationRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, List<LanguageModel>>> getAllLanguages() async {
    return await apiService.task(GetLanguageEndpoint());
  }

  @override
  Future<Either<HttpException, List<TimeIntervalModel>>> getAllInterval() async {
    return await apiService.task(GetIntervalsEndpoint());
  }

  @override
  Future<Either<HttpException, void>> setTiming(TimingInput input) async {
    return await apiService.task<void>(TimingEndpoint(input));
  }

  @override
  Future<String?> getFcmToken () async {
    return await apiService.getFcmToken();
  }
  @override
  Future<Either<HttpException, void>> setFcmToken(FcmTokenInput input) async {
    return await apiService.task<void>(FcmTokenEndpoint(input));
  }
}
