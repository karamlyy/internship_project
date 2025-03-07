
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';

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
            PrimaryText(
              text: L10n.onboardingHeader,
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 32,
              fontFamily: 'Inter',
            ),
            11.verticalSpace,
            PrimaryText(
              textAlign: TextAlign.center,
              text: L10n.onboardingSubheader,
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
