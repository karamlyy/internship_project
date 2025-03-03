import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/settings_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class AddLanguagePairCubit extends Cubit<BaseState> {
  AddLanguagePairCubit() : super(InitialState());

  final _homeRepository = getIt<HomeRepository>();
  final _settingsRepository = getIt<SettingsRepository>();

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

  Future<void> deleteLanguagePair(int id) async {
    emit(LoadingState());
    final result = await _settingsRepository.deleteLanguagePair(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllLanguagePairs();
      },
    );
  }

  Future<void> swapLanguages(int id) async {
    emit(LoadingState());
    final result = await _settingsRepository.swapLanguages(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllLanguagePairs();
      },
    );
  }

  Future<void> setSelectedLanguagePair(int id) async {
    emit(LoadingState());
    final result = await _settingsRepository.setSelectedLanguagePair(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllLanguagePairs();
      },
    );
  }
}
