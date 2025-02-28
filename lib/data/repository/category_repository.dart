import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/vocabulary/category_vocabulary_endpoint.dart';
import 'package:language_learning/data/endpoint/vocabulary/category_word_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/home/category_word_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class CategoryRepository {
  Future<Either<HttpException, List<CategoryWordModel>>> getAllCategoryWords(
      int categoryId);

  Future<Either<HttpException, void>> changeCategoryWordStatus(int vocabularyId);
}

class CategoryRepositoryImpl extends CategoryRepository {
  final ApiService apiService;

  CategoryRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, List<CategoryWordModel>>> getAllCategoryWords(
      int categoryId) async {
    return await apiService.task(CategoryVocabularyEndpoint(categoryId: categoryId));
  }

  @override
  Future<Either<HttpException, void>> changeCategoryWordStatus(int vocabularyId) async {
    return await apiService.task<void>(CategoryWordEndpoint(vocabularyId));
  }
}
