import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/settings/change_timing_endpoint.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart'
    show TimeIntervalModel;
import 'package:language_learning/data/repository/language_repository.dart';
import 'package:language_learning/data/repository/settings_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:rxdart/rxdart.dart';

class ChangeTimingCubit extends Cubit<BaseState> {
  ChangeTimingCubit() : super(InitialState()) {
    getTiming();
    getAllInterval();
  }

  final _intervalsController = BehaviorSubject<List<TimeIntervalModel>>();
  final _changeTimingController = BehaviorSubject<void>();

  Stream<List<TimeIntervalModel>> get intervalsController =>
      _intervalsController.stream;
  Stream<void> get changeTimingController => _changeTimingController.stream;

  final _settingRepository = getIt<SettingsRepository>();
  final _languageRepository = getIt<UserConfigurationRepository>();

  Future<void> getTiming() async {
    emit(LoadingState());
    final result = await _settingRepository.getTiming();

    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  void getAllInterval() async {
    final result = await _languageRepository.getAllInterval();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        _intervalsController.add(data);
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
