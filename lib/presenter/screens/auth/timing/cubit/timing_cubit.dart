import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/timing_endpoint.dart';
import 'package:language_learning/data/repository/language_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class TimingCubit extends Cubit<BaseState> {
  TimingCubit() : super(InitialState());

  final _languageRepository = getIt<UserConfigurationRepository>();

  Future<void> setTiming(BuildContext context, TimingInput input) async {
    emit(LoadingState());

    final prefs = await PreferencesService.instance;
    final result = await _languageRepository.setTiming(input);

    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) async {
        prefs.setAuthorizationPassed(true);
        prefs.setTimingPassed(true);
        Navigation.pushNamedAndRemoveUntil(Routes.home);
        context.read<HomeCubit>()
          ..getCardCounts()
          ..getLastWords()
          ..getAllLanguagePairs();
      },
    );
  }

  void getAllInterval() async {
    emit(LoadingState());
    final result = await _languageRepository.getAllInterval();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }
}
