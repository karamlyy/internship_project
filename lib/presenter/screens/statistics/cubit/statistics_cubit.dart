import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/statistics_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class StatisticsCubit extends Cubit<BaseState> {
  StatisticsCubit() : super(InitialState()){
    getQuizAccuracy();
  }

  final _statisticsRepository = getIt<StatisticsRepository>();

  void getQuizAccuracy() async {
    emit(LoadingState());
    final result = await _statisticsRepository.getQuizAccuracy();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  void getPersonalRecord() async {
    emit(LoadingState());
    final result = await _statisticsRepository.getPersonalRecord();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

}
