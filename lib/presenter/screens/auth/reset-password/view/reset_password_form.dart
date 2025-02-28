import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/provider/resetPasswordProvider.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/view/reset_password_button.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final resetPasswordProvider = context.watch<ResetPasswordProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(
            headingText: 'Reset password',
            secondaryText: 'Please type something you’ll remember',
          ),
          39.verticalSpace,
          PrimaryTextFormField(
            headText: 'New password',
            hint: 'must be 8 characters',
            onChanged: (value) => resetPasswordProvider.updatePassword(value),
            isObscureText: !resetPasswordProvider.isPasswordVisible,
            hasError: resetPasswordProvider.passwordError != null,
            suffixIcon: IconButton(
              iconSize: 20.h,
              padding: const EdgeInsets.all(16.0).r,
              onPressed: () {
                resetPasswordProvider.changePasswordVisibility(
                    !resetPasswordProvider.isPasswordVisible);
              },
              icon: Icon(
                resetPasswordProvider.isPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.primaryText.withValues(alpha: 0.6),
              ),
            ),
          ),
          16.verticalSpace,
          PrimaryTextFormField(
            headText: 'Confirm password',
            hint: 'repeat password',
            onChanged: (value) =>
                resetPasswordProvider.updateConfirmPassword(value),
            isObscureText: !resetPasswordProvider.isConfirmPasswordVisible,
            hasError: resetPasswordProvider.confirmPasswordError != null,
            suffixIcon: IconButton(
              iconSize: 20.h,
              padding: const EdgeInsets.all(16.0).r,
              onPressed: () {
                resetPasswordProvider.changeConfirmPasswordVisibility(
                    !resetPasswordProvider.isConfirmPasswordVisible);
              },
              icon: Icon(
                resetPasswordProvider.isConfirmPasswordVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.primaryText.withValues(alpha: 0.6),
              ),
            ),
          ),
          32.verticalSpace,
          ResetPasswordButton(),
        ],
      ),
    );
  }
}
