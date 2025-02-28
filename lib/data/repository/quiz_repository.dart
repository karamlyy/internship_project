import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/quiz/quiz_endpoint.dart';
import 'package:language_learning/data/endpoint/quiz/report_quiz_endpoint.dart';
import 'package:language_learning/data/endpoint/word/add_master_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/quiz/question_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class QuizRepository {
  Future<Either<HttpException, QuestionModel>> getQuizQuestion(List<int> excludeIds, {bool? isMastered});
  Future<Either<HttpException, void>> addToMaster(int id, bool addToLearning);
  Future<Either<HttpException, void>> createQuizReport(int correctAnswerCount);
}

class QuizRepositoryImpl extends QuizRepository {
  final ApiService apiService;

  QuizRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, QuestionModel>> getQuizQuestion(List<int> excludeIds, {bool? isMastered}) async {
    return await apiService.task(QuizEndpoint(excludeIds: excludeIds, isMastered: isMastered));
  }

  @override
  Future<Either<HttpException, void>> addToMaster(int id, bool addToLearning) async {
    return await apiService.task(AddToMasterEndpoint(id: id, addToLearning: addToLearning));
  }

  @override
  Future<Either<HttpException, void>> createQuizReport(int correctAnswerCount) async{
    return await apiService.task(ReportQuizEndpoint(correctAnswerCount: correctAnswerCount));
  }
}
