import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const SettingsCard({
    super.key,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.unselectedItemBackground,
      elevation: 0,
      child: ListTile(
        title: PrimaryText(
          text: title,
          color: AppColors.primaryText,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        onTap: onTap,
        leading: leadingIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26).r,
        ),
        iconColor: iconColor,
        trailing: trailingIcon,
      ),
    );
  }
}
