import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/login/provider/login_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryTextFormField(
                    headText: "Email address",
                    hint: 'Enter email address',
                    errorText: loginProvider.emailError,
                    onChanged: loginProvider.updateEmail,
                    isObscureText: false,
                    hasError: loginProvider.emailError != null,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(16.0).r,
                      child: Icon(
                        loginProvider.emailError != null
                            ? Icons.error
                            : (loginProvider.email.isNotEmpty
                                ? CupertinoIcons.check_mark_circled_solid
                                : Icons.mail),
                        color: AppColors.primaryText.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  PrimaryTextFormField(
                    hint: 'Enter password',
                    headText: "Password",
                    errorText: loginProvider.passwordError,
                    onChanged: loginProvider.updatePassword,
                    isObscureText: !loginProvider.isPasswordVisible,
                    hasError: loginProvider.passwordError != null,
                    suffixIcon: IconButton(
                      iconSize: 20.h,
                      padding: const EdgeInsets.all(16.0).r,
                      onPressed: () {
                        loginProvider.changePasswordVisibility(
                            !loginProvider.isPasswordVisible);
                      },
                      icon: Icon(
                        loginProvider.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryText.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          overlayColor: Colors.transparent),
                      child: const PrimaryText(
                        text: 'Forgot password?',
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                      onPressed: () {
                        Navigation.push(Routes.forgotPassword);
                      },
                    ),
                  ),
                  42.verticalSpace,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
