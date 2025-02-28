import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/auth/forgot_password_model.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/cubit/reset_password_cubit.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/cubit/reset_password_state.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/provider/resetPasswordProvider.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/view/reset_password_body.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  final ForgotPasswordModel forgotPasswordModel;

  const ResetPasswordPage({
    super.key,
    required this.forgotPasswordModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => ResetPasswordProvider()
            ..setUserId(forgotPasswordModel.userId ?? ''),
          child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {},
            child: ResetPasswordBody(
              userId: forgotPasswordModel.userId ?? '',
              codeExpiry: '',
            ),
          ),
        ),
      ),
    );
  }
}
