import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<BaseState> {
  SettingsCubit() : super(InitialState());

  final _authRepository = getIt<AuthRepository>();

  void deleteUser() async {
    emit(LoadingState());
    final prefs = await PreferencesService.instance;
    final result = await _authRepository.deleteUser();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        prefs.clear();
        Navigation.pushNamedAndRemoveUntil(Routes.login);
      },
    );
  }

  void logoutUser() async {
    emit(LoadingState());

    final prefs = await PreferencesService.instance;
    log("Old token: ${prefs.accessToken}");

    await prefs.clear();

    emit(SuccessState(data: null));

    Navigation.pushNamedAndRemoveUntil(Routes.login);
  }
}
