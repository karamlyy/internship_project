import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/data/model/word/list_word_model.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';

import '../../../../data/model/home/word_pair_model.dart';

class VocabularyAiCubit extends Cubit<BaseState> {
  VocabularyAiCubit() : super(InitialState()) {
    getAllWordsList();
  }

  final _wordRepository = getIt<WordRepository>();
  final _homeRepository = getIt<HomeRepository>();
  final _vocabularyRepository = getIt<VocabularyRepository>();

  List<WordPairModel> _allWords = [];

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

  void getMasteredVocabulary() async {
    emit(LoadingState());
    final result = await _vocabularyRepository.getAllMasterWords();
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
      (error) => emit(FailureState(errorMessage: error.error)),
      (listWordModel) {
        _allWords = listWordModel.items;

        emit(SuccessState(data: _allWords));
      },
    );
  }

  Future<void> addToLearning(int id) async {
    final result = await _wordRepository.addToLearning(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {},
    );
  }

  void searchWord(String query) async {
    if (query.isEmpty) {
      return;
    }

    emit(LoadingState());
    final result = await _wordRepository.searchWord(query);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (listWordModel) {
        final searchResults = listWordModel.items;
        emit(SuccessState(data: searchResults));
      },
    );
  }
}
