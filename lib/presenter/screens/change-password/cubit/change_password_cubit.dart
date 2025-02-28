import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/change_password_endpoint.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ChangePasswordCubit extends Cubit<BaseState> {
  ChangePasswordCubit() : super(InitialState());

  final _authRepository = getIt<AuthRepository>();

  void changePassword(ChangePasswordInput input) async {
    emit(LoadingState());
    final result = await _authRepository.changePassword(input);

    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        Navigation.pushReplacementNamed(Routes.settings);
      },
    );
  }
}
