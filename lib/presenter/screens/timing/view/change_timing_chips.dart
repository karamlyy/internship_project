import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';


class ChangeTimingChipsList extends StatelessWidget {
  const ChangeTimingChipsList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChangeTimingProvider>();

    return StreamBuilder<List<TimeIntervalModel>>(
      stream: context.read<ChangeTimingCubit>().intervalsController,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final intervals = snapshot.data ?? [];
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.w),
            itemCount: intervals.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final interval = intervals[index];
              final isSelected = provider.selectedIntervalId == interval.id;

              return GestureDetector(
                onTap: () {
                  provider.selectInterval(interval.id!);
                  print('Tapped Interval ID: ${interval.id}');

                },
                child: AnimatedContainer(
                  width: double.infinity,
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.background,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.itemBorder,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: PrimaryText(
                    text: interval.name,
                    color: isSelected ? AppColors.background : AppColors.primaryText,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,


                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          print('snapshot error: ${snapshot.error}');
          return Center(child: Text('Failed to load intervals', style: TextStyle(color: AppColors.error)));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}