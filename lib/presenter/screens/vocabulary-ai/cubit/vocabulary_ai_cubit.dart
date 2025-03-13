import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/file_repository.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/downloader-service/downloader_service.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

import '../../../../data/model/home/word_pair_model.dart';

class VocabularyAiCubit extends Cubit<BaseState> {
  VocabularyAiCubit() : super(InitialState()) {
    getAllWordsList();
  }

  final _wordRepository = getIt<WordRepository>();
  final _homeRepository = getIt<HomeRepository>();
  final _vocabularyRepository = getIt<VocabularyRepository>();
  final _fileRepository = getIt<FileRepository>();

  final _downloaderService = DownloaderService();

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

  void exportWords(List<int> selectedWordIds) async {
    emit(LoadingState());
    final result = await _fileRepository.exportWords(selectedWordIds);
    result.fold(
          (error) => emit(FailureState(errorMessage: error.error)),
          (data) async {
        await _downloaderService.convertBase64ToExcel(base64String: data.fileContent ?? '');
        Navigation.push(Routes.home);
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
