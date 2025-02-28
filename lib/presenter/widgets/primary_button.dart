import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final double? borderRadius;
  final Color? backgroundColor;

  final bool isActive;

  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.hasBorder,
    this.borderRadius,
    this.backgroundColor,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: hasBorder
            ? AppColors.background
            : isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.7),
        minimumSize: Size(
          double.infinity,
          56.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 10.r),
          side: isActive
              ? const BorderSide(color: AppColors.primary)
              : BorderSide.none,
        ),
      ),
      child: PrimaryText(
        text: title,
        color: hasBorder
            ? AppColors.primary
            : isActive
                ? AppColors.background
                : AppColors.primaryText.withValues(alpha: 0.5),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
