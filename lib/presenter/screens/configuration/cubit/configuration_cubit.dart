import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/repository/settings_repository.dart';
import '../../../../data/service/api/di.dart';
import '../../../../generic/base_state.dart';
/*
class ConfigurationCubit extends Cubit<BaseState> {
  ConfigurationCubit() : super(InitialState()) {
    getSettings();
  }

  final _visibilityController = BehaviorSubject<void>();
  Stream<void> get visibilityController => _visibilityController.stream;

  final _settingRepository = getIt<SettingsRepository>();

  void getSettings() async {
    emit(LoadingState());
    final result = await _settingRepository.getUserSettings();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  Future<void> changeQuizVisibility() async {
    emit(LoadingState());
    final result = await _settingRepository.changeQuizVisibility();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        _visibilityController.add(data);
      },
    );
  }
}
*/


class ConfigurationCubit extends Cubit<BaseState> {
  ConfigurationCubit() : super(InitialState()) {
    getSettings();
  }

  final _settingRepository = getIt<SettingsRepository>();

  void getSettings() async {
    emit(LoadingState());
    final result = await _settingRepository.getUserSettings();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  void changeQuizVisibility() async {
    emit(LoadingState());
    final result = await _settingRepository.changeQuizVisibility();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getSettings();
      },
    );
  }
}


