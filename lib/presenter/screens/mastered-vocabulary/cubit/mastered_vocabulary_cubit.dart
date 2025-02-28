import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/vocabulary_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class MasteredVocabularyCubit extends Cubit<BaseState> {
  MasteredVocabularyCubit() : super(InitialState()) {
    getMasteredVocabulary();
  }

  final _vocabularyRepository = getIt<VocabularyRepository>();
  final _wordRepository = getIt<WordRepository>();

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
