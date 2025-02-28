import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/register/provider/register_provider.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PrimaryTextFormField(
              hint: 'Email address',
              errorText: registerProvider.emailError,
              onChanged: registerProvider.updateEmail,
              isObscureText: false,
              hasError: registerProvider.emailError != null,
              suffixIcon: Padding(
                padding:  const EdgeInsets.all(16).r,
                child: Icon(
                  registerProvider.emailError != null
                      ? null
                      : (registerProvider.email.isNotEmpty
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.mail_solid),
                  color: AppColors.primaryText.withValues(alpha: 0.6),
                  size: 20.h,
                ),
              ),
            ),
            16.verticalSpace,
            PrimaryTextFormField(
              hint: 'Password',
              errorText: registerProvider.passwordError,
              onChanged: registerProvider.updatePassword,
              isObscureText: !registerProvider.isPasswordVisible,
              hasError: registerProvider.passwordError != null,
              suffixIcon: IconButton(
                iconSize: 20.h,
                padding: const EdgeInsets.all(16.0).r,
                onPressed: () {
                  registerProvider.changePasswordVisibility(
                      !registerProvider.isPasswordVisible);
                },
                icon: Icon(
                  registerProvider.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.primaryText.withValues(alpha: 0.6),
                ),
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(

                  visualDensity: VisualDensity.compact,
                  value: registerProvider.isTermsAndConditionsAccepted,
                  onChanged: (value) {
                    registerProvider.acceptTermsAndConditions(value ?? false);
                  },
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10.0).r,
                  ),
                  activeColor: AppColors.background,
                  checkColor: AppColors.primary,
                  side: BorderSide(
                    width: 1.0,

                    color: AppColors.primary,
                  ),
                ),
                const PrimaryText(
                  text: 'I accept the terms and privacy policy',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            16.verticalSpace,
            const RegisterButton(),
          ],
        ),
      );
    });
  }
}