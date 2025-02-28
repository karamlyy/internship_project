import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class LearningVocabularyCubit extends Cubit<BaseState> {
  LearningVocabularyCubit() : super(InitialState()) {
    getLearningVocabulary();
  }

  final _vocabularyRepository = getIt<VocabularyRepository>();
  final _wordRepository = getIt<WordRepository>();
  final _homeRepository = getIt<HomeRepository>();

  void getAllLanguagePairs() async {
    emit(LoadingState());
    final result = await _homeRepository.getAllLanguagePairs();
    result.fold(
          (error) => emit(FailureState(errorMessage: error.error)),
          (data) {
        emit(SuccessState(data: data));
      },
    );
  }


  void getLearningVocabulary() async {
    emit(LoadingState());
    final result = await _vocabularyRepository.getAllLearningWords();
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  Future<void> addToLearning(int id) async {
    final result = await _wordRepository.addToLearning(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        getLearningVocabulary();
      },
    );
  }
}
