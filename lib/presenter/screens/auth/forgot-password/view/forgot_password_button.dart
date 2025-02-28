import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/auth/forgot-password/cubit/forgot_password_cubit.dart';
import 'package:language_learning/presenter/screens/auth/forgot-password/provider/forgot_password_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = context.watch<ForgotPasswordProvider>();
    final forgotPasswordCubit = context.read<ForgotPasswordCubit>();
    return GenericBuilder<ForgotPasswordCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }
        return PrimaryButton(
          title: 'Send code',
          hasBorder: false,
          isActive: forgotPasswordProvider.isEmailValid(),
          onTap: () {
            forgotPasswordCubit.applyForgotPassword(forgotPasswordProvider.forgotPasswordInput);
          },
        );
      },
    );
  }
}