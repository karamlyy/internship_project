import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/vocabulary/category_word_endpoint.dart';
import 'package:language_learning/data/repository/category_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class CategoryCubit extends Cubit<BaseState> {
  final int categoryId;

  CategoryCubit(this.categoryId) : super(InitialState()) {
    getCategoryWords(categoryId);
  }

  final _categoryRepository = getIt<CategoryRepository>();

  Future<void> getCategoryWords(int id) async {
    emit(LoadingState());
    final result = await _categoryRepository.getAllCategoryWords(id);
    result.fold(
          (error) => emit(
        FailureState(errorMessage: error.error),
      ),
          (data) {
        emit(SuccessState(data: data));
      },
    );
  }


  Future<void> changeWordStatus(int vocabularyId) async {
    final result =
    await _categoryRepository.changeCategoryWordStatus(vocabularyId);

    result.fold(
          (error) => emit(FailureState(errorMessage: error.error)),
          (data) async {
        print('Status changed successfully');
        await getCategoryWords(categoryId);
      },
    );
  }

}
