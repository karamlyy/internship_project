import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/reset_password_endpoint.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/cubit/reset_password_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final _authRepository = getIt<AuthRepository>();

  void resetPassword(ResetPasswordInput input) async {
    emit(ResetPasswordLoading());
    final result = await _authRepository.resetPassword(input);
    result.fold(
      (error) => emit(ResetPasswordFailure(errorMessage: error.error)),
      (data) {
        Navigation.push(Routes.passwordChanged);
        print('password changed');
      },
    );
  }
}