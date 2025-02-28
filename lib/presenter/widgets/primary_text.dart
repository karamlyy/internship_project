import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration? haveUnderline;


  const PrimaryText({
    super.key,
     this.text,
    required this.color,
    required this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.fontSize,
    this.haveUnderline

  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(
        decoration: haveUnderline,
        decorationColor: AppColors.primary,
        color: color,
        fontSize: fontSize?.sp ?? 14.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
