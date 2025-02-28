import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/auth/timing/provider/timing_provider.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_interval_chips.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class TimingForm extends StatelessWidget {
  const TimingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final timingProvider = context.watch<TimingProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingText(
            headingText: 'Choosen time for learning',
            secondaryText: 'Choosen time for receiving notifications',
          ),
          42.verticalSpace,
          PrimaryText(
            text: 'Select Time Range',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildTimePickerField(
                  context: context,
                  label: 'Start time',
                  selectedTime: timingProvider.startTime,
                  onTimeSelected: (time) => timingProvider.setStartTime(time),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _buildTimePickerField(
                  context: context,
                  label: 'End time',
                  selectedTime: timingProvider.endTime,
                  onTimeSelected: (time) => timingProvider.setEndTime(time),
                ),
              ),
            ],
          ),
          32.verticalSpace,
          PrimaryText(
            text: 'Select Notification Interval',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w600,
          ),
          16.verticalSpace,

        ],
      ),
    );
  }

  Widget _buildTimePickerField({
    required BuildContext context,
    required String label,
    required DateTime? selectedTime,
    required Function(DateTime) onTimeSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime != null
              ? TimeOfDay.fromDateTime(selectedTime)
              : TimeOfDay.now(),
        );

        if (pickedTime != null) {
          DateTime now = DateTime.now();
          DateTime selectedDateTime = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          onTimeSelected(selectedDateTime);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryText(
            text: label,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
          ),
          6.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.itemBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryText(
                  text: selectedTime != null
                      ? DateFormat.jm().format(selectedTime)
                      : "00:00",
                  fontSize: 16,
                  color: selectedTime != null
                      ? AppColors.primaryText
                      : AppColors.primaryText.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
                Icon(
                  Icons.access_time,
                  size: 15.w,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
