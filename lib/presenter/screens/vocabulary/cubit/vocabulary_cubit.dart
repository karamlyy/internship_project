import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';

class VocabularyCubit extends Cubit<BaseState> {
  VocabularyCubit() : super(InitialState()) {
    getAllWordsList();
  }

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

  void getAllWords() async {
    emit(LoadingState());
    final result = await _wordRepository.getAllWords(1, 20);
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  void getAllWordsList() async {
    emit(LoadingState());
    final result = await _wordRepository.getAllWordsList();
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  Future<void> deleteWord(int id) async {
    emit(LoadingState());
    final result = await _wordRepository.deleteWord(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllWords();
      },
    );
  }

  Future<void> updateWord(UpdateWordInput input) async {
    emit(LoadingState());
    final result = await _wordRepository.updateWord(input);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllWordsList();
      },
    );
  }

  Future<void> addToLearning(int id) async {
    final result = await _wordRepository.addToLearning(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        getAllWordsList();
      },
    );
  }

  /*
  Future<void> addToLearning(
      int id, VocabularyProvider vocabularyProvider) async {
    final result = await _wordRepository.addToLearning(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        vocabularyProvider.changeWordStatus(!vocabularyProvider.isAdded);
      },
    );
  }

   */

  void searchWord(String query) async {
    if (query.isEmpty) {
      getAllWords();
      return;
    }

    emit(LoadingState());
    final result = await _wordRepository.searchWord(query, 1, 20);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) => emit(SuccessState(data: data)),
    );
  }
}
