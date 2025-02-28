import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/register/provider/register_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class RegisterHelperButtons extends StatelessWidget {
  const RegisterHelperButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.watch<RegisterProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Switch(
            value: registerProvider.isWeeklySummaryEnabled,
            onChanged: (bool value) {
              registerProvider.toggleWeeklySummary(value);
            },
            activeColor: AppColors.background,
            activeTrackColor: AppColors.toggleBackground,
            inactiveThumbColor: AppColors.toggleBackground,
            inactiveTrackColor: AppColors.toggleOffBackground,
            trackOutlineWidth: WidgetStateProperty.all(0.1),
          ),
          4.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PrimaryText(
                text: 'Weekly summary',
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              4.verticalSpace,
              PrimaryText(
                text: 'Get weekly activity report by email',
                color: AppColors.primaryText.withValues(
                  alpha: 0.7,
                ),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}