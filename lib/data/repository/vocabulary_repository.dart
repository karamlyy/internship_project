import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/home/user_vocabulary_leaning_endpoint.dart';
import 'package:language_learning/data/endpoint/home/user_vocabulary_mastered_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/home/user_vocabulary_model.dart';
import 'package:language_learning/data/model/word/list_word_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class VocabularyRepository {
  Future<Either<HttpException, ListWordModel>> getAllLearningWords(
      );

  Future<Either<HttpException, ListWordModel>> getAllMasterWords(
     );
}

class VocabularyRepositoryImpl extends VocabularyRepository {
  final ApiService apiService;

  VocabularyRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, ListWordModel>> getAllLearningWords(
      ) async {
    return await apiService
        .task(GetAllLearningWordsEndpoint());
  }

  @override
  Future<Either<HttpException, ListWordModel>> getAllMasterWords(
    ) async {
    return await apiService
        .task(GetAllMasteredWordsEndpoint());
  }
}
