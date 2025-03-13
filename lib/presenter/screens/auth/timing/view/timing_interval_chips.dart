import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class TimingIntervalChips extends StatelessWidget {
  final List<TimeIntervalModel> intervalChips;
  final int? selectedIntervalId;
  final Function(int) onIntervalSelected;

  const TimingIntervalChips({
    super.key,
    required this.intervalChips,
    required this.selectedIntervalId,
    required this.onIntervalSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          itemCount: intervalChips.length,
          itemBuilder: (context, index) {
            final intervalChip = intervalChips[index];
            final isSelected = selectedIntervalId == intervalChip.id;

            return GestureDetector(
              onTap: () {
                onIntervalSelected(intervalChip.id ?? 0);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12).r,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.unselectedItemBackground,
                  borderRadius: BorderRadius.circular(8).r,
                  border: Border.all(
                    color: isSelected ? AppColors.itemBorder : Colors.transparent,
                  ),
                ),
                child: Row(
                  children: [

                    16.horizontalSpace,
                    PrimaryText(
                      text: intervalChip.name,
                      color: isSelected
                          ? AppColors.background
                          : AppColors.primaryText.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
