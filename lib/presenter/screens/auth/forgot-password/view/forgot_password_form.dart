import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/forgot-password/provider/forgot_password_provider.dart';
import 'package:language_learning/presenter/screens/auth/forgot-password/view/forgot_password_button.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = context.watch<ForgotPasswordProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(
              headingText: 'Forgot Password?', secondaryText: 'Don’t worry! It happens. Please enter the email associated with your account.'),
          32.verticalSpace,
          PrimaryTextFormField(
            headText: "Email address",
            hint: 'Enter email address',
            onChanged: forgotPasswordProvider.updateEmail,
            isObscureText: false,
            hasError: forgotPasswordProvider.emailError != null,
            suffixIcon: IconButton(
              iconSize: 20.h,
              padding: const EdgeInsets.all(16.0).r,
              onPressed: () {},
              icon: Icon(
                forgotPasswordProvider.emailError != null
                    ? null
                    : (forgotPasswordProvider.email.isNotEmpty ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.mail_solid),
                color: AppColors.primaryText.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
          ),
          32.verticalSpace,
          ForgotPasswordButton(),
        ],
      ),
    );
  }
}