import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class PasswordChangedBody extends StatelessWidget {
  const PasswordChangedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const HeadingText(
              headingText: 'Password changed',
              secondaryText: 'Your password has been changed successfully',
              crossAxisAlignment: CrossAxisAlignment.center,
              textAlign: TextAlign.center,
            ),
            32.verticalSpace,
            PrimaryButton(
              title: 'Back to login',
              hasBorder: false,
              isActive: true,
              onTap: () {
                Navigation.push(Routes.login);
              },
              borderRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}
