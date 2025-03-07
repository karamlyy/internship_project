import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/change-password/provider/change_password_provider.dart';
import 'package:language_learning/presenter/screens/change-password/view/change_password_header.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:provider/provider.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = context.watch<ChangePasswordProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChangePasswordHeader(),
        10.verticalSpace,
        PrimaryTextFormField(
          headText: L10n.password,
          hint: L10n.passwordMustBe8Chars,
          isObscureText: !changePasswordProvider.isPasswordVisible,
          hasError: changePasswordProvider.passwordError != null,
          suffixIcon: IconButton(
            iconSize: 20.h,
            padding: const EdgeInsets.all(16.0).r,
            onPressed: () {
              changePasswordProvider.changePasswordVisibility(
                !changePasswordProvider.isPasswordVisible,
              );
            },
            icon: Icon(
              changePasswordProvider.isPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.primaryText.withValues(alpha: 0.6),
            ),
          ),
          onChanged: changePasswordProvider.updatePassword,
        ),
        16.verticalSpace,
        PrimaryTextFormField(
          headText: 'New password',
          hint: L10n.passwordMustBe8Chars,
          isObscureText: !changePasswordProvider.isNewPasswordVisible,
          hasError: changePasswordProvider.passwordError != null,

          suffixIcon: IconButton(
            iconSize: 20.h,
            padding: const EdgeInsets.all(16.0).r,
            onPressed: () {
              changePasswordProvider.changeNewPasswordVisibility(
                !changePasswordProvider.isNewPasswordVisible,
              );
            },
            icon: Icon(
              changePasswordProvider.isNewPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.primaryText.withValues(alpha: 0.6),
            ),
          ),
          onChanged: changePasswordProvider.updateNewPassword,
        ),
        16.verticalSpace,
        PrimaryTextFormField(
          headText: 'Password',
          hint: 'repeat password',
          isObscureText: !changePasswordProvider.isConfirmPasswordVisible,
          hasError: changePasswordProvider.passwordError != null,
          suffixIcon: IconButton(
            iconSize: 20.h,
            padding: const EdgeInsets.all(16.0).r,
            onPressed: () {
              changePasswordProvider.changeConfirmPasswordVisibility(
                !changePasswordProvider.isConfirmPasswordVisible,
              );
            },
            icon: Icon(
              changePasswordProvider.isConfirmPasswordVisible
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.primaryText.withValues(alpha: 0.6),
            ),
          ),
          onChanged: changePasswordProvider.updateConfirmPassword,
        ),
      ],
    );
  }
}
