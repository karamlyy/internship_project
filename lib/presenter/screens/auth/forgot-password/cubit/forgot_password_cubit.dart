import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/forgot_password_endpoint.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ForgotPasswordCubit extends Cubit<BaseState> {
  ForgotPasswordCubit() : super(InitialState());

  final _authRepository = getIt<AuthRepository>();

  void applyForgotPassword(ForgotPasswordInput input) async {
    emit(LoadingState());
    final result = await _authRepository.applyForgotPassword(input);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        emit(SuccessState(data: data));
        print('forgot password email sent successfully');
        Navigation.push(Routes.verifyCode, arguments: data);
      },
    );
  }
}
