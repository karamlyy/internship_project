import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class ChangeTimingChips extends StatelessWidget {
  const ChangeTimingChips({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTimingProvider = context.watch<ChangeTimingProvider>();

    return Wrap(
      spacing: 16.0.w,
      children: changeTimingProvider.intervals.map((interval) {
        final isSelected =
            changeTimingProvider.selectedIntervalId == interval.id;

        return BlocBuilder<ChangeTimingCubit, BaseState>(
          builder: (context, state) {
            if (state is SuccessState) {
              final data = state.data;

              return ChoiceChip(
                showCheckmark: false,
                label: PrimaryText(
                  text: interval.title,
                  color: isSelected
                      ? AppColors.itemBackground
                      : AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    changeTimingProvider.selectInterval(interval.id);
                  }
                },
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                  vertical: 10.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44.0).r,
                  side: const BorderSide(color: AppColors.itemBorder),
                ),
                selectedColor: AppColors.primary,
                backgroundColor: data.intervalId == interval.id
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : AppColors.unselectedItemBackground,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
