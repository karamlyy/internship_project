import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/notification_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';

class NotificationCubit extends Cubit<BaseState> {
  NotificationCubit() : super(InitialState()) {
    getAllCategories();
  }

  final _notificationRepository = getIt<NotificationRepository>();

  void getAllCategories() async {
    emit(LoadingState());
    final result = await _notificationRepository.getAllNotification();
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }
}
