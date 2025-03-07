import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/file_repository.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/downloader-service/downloader_service.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class MasteredVocabularyCubit extends Cubit<BaseState> {
  MasteredVocabularyCubit() : super(InitialState()) {
    getMasteredVocabulary();
  }
  
  final _downloadService = DownloaderService();

  final _vocabularyRepository = getIt<VocabularyRepository>();
  final _wordRepository = getIt<WordRepository>();
  final _fileRepository = getIt<FileRepository>();

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

  void exportMasteredWords(List<int> selectedWordIds) async {
    emit(LoadingState());
    final result = await _fileRepository.exportWords(selectedWordIds);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) async {
        await _downloadService.convertBase64ToExcel(base64String: data.fileContent ?? '');
        Navigation.push(Routes.home);
      },
    );
  }

  Future<void> removeFromMastered(int id) async {
    final result = await _wordRepository.removeFromMastered(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        getMasteredVocabulary();
      },
    );
  }
}
