import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class HeadingText extends StatelessWidget {
  final String headingText;
  final String? secondaryText;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? textAlign;


  const HeadingText({
    super.key,
    required this.headingText,
    this.secondaryText,
    this.crossAxisAlignment,
    this.textAlign,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        PrimaryText(
          text: headingText,
          color: AppColors.primaryText,
          fontWeight: FontWeight.w400,
          fontFamily: 'DMSerifDisplay',
          fontSize: 28,
        ),
        12.verticalSpace,
        PrimaryText(
          text: secondaryText ?? '',
          color: AppColors.primaryText.withValues(alpha: 0.6),
          fontWeight: FontWeight.w400,
          fontSize: 16,
          textAlign: textAlign ?? TextAlign.start,
        ),
      ],
    );
  }
}
