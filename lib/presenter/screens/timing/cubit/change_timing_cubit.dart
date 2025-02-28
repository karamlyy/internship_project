import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/settings/change_timing_endpoint.dart';
import 'package:language_learning/data/repository/settings_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ChangeTimingCubit extends Cubit<BaseState> {
  ChangeTimingCubit() : super(InitialState()){
    getTiming();
  }

  final _settingRepository = getIt<SettingsRepository>();

  void getTiming() async {
    emit(LoadingState());
    final result = await _settingRepository.getTiming();

    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  void changeTiming(ChangeTimingInput input) async {
    emit(LoadingState());
    final result = await _settingRepository.changeTiming(input);

    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        Navigation.pushNamedAndRemoveUntil(Routes.home);
      },
    );
  }
}
