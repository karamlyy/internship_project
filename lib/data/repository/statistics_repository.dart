import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/statistics/get_personal_records_endpoint.dart';
import 'package:language_learning/data/endpoint/statistics/get_quiz_accuracy_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/statistics/personal_record_model.dart';
import 'package:language_learning/data/model/statistics/quiz_accuracy_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class StatisticsRepository {
  Future<Either<HttpException, QuizAccuracyModel>> getQuizAccuracy();
  Future<Either<HttpException, PersonalRecordModel>> getPersonalRecord();


}

class StatisticsRepositoryImpl extends StatisticsRepository {
  final ApiService apiService;

  StatisticsRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, QuizAccuracyModel>> getQuizAccuracy() async{
    return await apiService.task<QuizAccuracyModel>(GetQuizAccuracyEndpoint());
  }

  @override
  Future<Either<HttpException, PersonalRecordModel>> getPersonalRecord() async {
    return await apiService.task<PersonalRecordModel>(GetPersonalRecordsEndpoint());
  }

}
