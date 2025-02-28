import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/auth/verify_code_endpoint.dart';
import 'package:language_learning/data/model/auth/forgot_password_model.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/cubit/verify_code_state.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit(this.forgotPasswordModel) : super(VerifyCodeInitial());

  final ForgotPasswordModel forgotPasswordModel;

  final _authRepository = getIt<AuthRepository>();

  void verifyCode(VerifyCodeInput input) async {
    emit(VerifyCodeInitial());
    final result = await _authRepository.verifyCode(input);

    result.fold(
      (error) => emit(VerifyCodeFailure(errorMessage: error.error)),
      (data) {
        Navigation.pushNamedAndRemoveUntil(
          Routes.resetPassword,
          arguments: forgotPasswordModel
        );
        print('successful VerifyCode data:  ');
      },
    );
  }
}
