import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/settings_repository.dart';
import '../../../../data/service/api/di.dart';
import '../../../../generic/base_state.dart';


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

  void changeNotificationStatus() async {
    emit(LoadingState());
    final result = await _settingRepository.changeNotificationStatus();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getSettings();
      },
    );
  }

  void changeQuizListenable() async {
    emit(LoadingState());
    final result = await _settingRepository.changeQuizListenable();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getSettings();
      },
    );
  }
}


