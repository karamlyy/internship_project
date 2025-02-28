import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/cubit/reset_password_cubit.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/provider/resetPasswordProvider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPasswordProvider = context.watch<ResetPasswordProvider>();
    final resetPasswordCubit = context.read<ResetPasswordCubit>();
    return PrimaryButton(
      title: 'Reset password',
      hasBorder: false,
      isActive: resetPasswordProvider.isFormValid(),
      onTap: () {
        resetPasswordCubit.resetPassword(
          resetPasswordProvider.resetPasswordInput,
        );
      },
    );
  }
}
