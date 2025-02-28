
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PrimaryText(
              text: 'Explore the app',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 32,
              fontFamily: 'DMSerifDisplay',
            ),
            11.verticalSpace,
            const PrimaryText(
              textAlign: TextAlign.center,
              text:
              'Create your vocabulary, get reminders, and test your memory with quick quizzes!',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ],
        ),
      ),
    );
  }
}
