import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';


class VocabularyCubit extends Cubit<BaseState> {
  VocabularyCubit() : super(InitialState()) {
    getAllWordsList();
    //getAllWords();
  }

  final _wordRepository = getIt<WordRepository>();
  final _homeRepository = getIt<HomeRepository>();

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

  Future<void> getAllWords() async {
    emit(LoadingState());
    final result = await _wordRepository.getAllWords(1, 10);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {

        emit(SuccessState(data: data));
        _allWords = data.items;
      },
    );
  }


  Future<void> getAllWordsList() async {
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

  Future<void> deleteWord(int id, int selectedSegmentIndex) async {
    emit(LoadingState());
    final result = await _wordRepository.deleteWord(id);
    result.fold(
          (error) => emit(FailureState(errorMessage: error.error)),
          (_) async {
        await getAllWordsList();
        filterWordsBySegment(selectedSegmentIndex);
      },
    );
  }

  Future<void> deleteAllWords() async{
    emit(LoadingState());
    final result = await _wordRepository.deleteAllWords();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        Navigation.push(Routes.home);
      },
    );
  }

  Future<void> updateWord(UpdateWordInput input) async {
    emit(LoadingState());
    final result = await _wordRepository.updateWord(input);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        getAllWordsList();
      },
    );
  }

  Future<void> addToLearning(int id) async {
    final result = await _wordRepository.addToLearning(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        //getAllWordsList();
      },
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


  void filterWordsBySegment(int segmentIndex) {
    List<WordPairModel> filteredWords;

    switch (segmentIndex) {
      case 0:
        filteredWords = _allWords;
        break;
      case 1:
        filteredWords = _allWords.where((word) => word.isLearningNow).toList();
        break;
      case 2:
        filteredWords = _allWords
            .where((word) => !word.isLearningNow && !word.isMastered)
            .toList();
        break;
      default:
        filteredWords = _allWords;
        break;
    }

    emit(SuccessState(data: filteredWords));
  }


}
