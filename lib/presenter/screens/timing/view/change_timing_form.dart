import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_chips.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_header.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:intl/intl.dart';

class ChangeTimingForm extends StatelessWidget {
  const ChangeTimingForm({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTimingProvider = context.watch<ChangeTimingProvider>();

    return BlocBuilder<ChangeTimingCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final data = state.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            changeTimingProvider.initialize(
              intervalId: data.intervalId,
              startTime: data.startTime,
              endTime: data.endTime,
            );
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChangeTimingHeader(),
              42.verticalSpace,
              PrimaryText(
                text: 'Select Time Range',
                color: AppColors.primaryText,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                textAlign: TextAlign.start,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTimePickerField(
                      context: context,
                      label: 'Start Time',
                      selectedTime: changeTimingProvider.startTime ??
                          _parseTimeString(data.startTime),
                      onTimeSelected: (newTime) {
                        changeTimingProvider.setStartTime(newTime);
                      },
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: _buildTimePickerField(
                      context: context,
                      label: 'End Time',
                      selectedTime: changeTimingProvider.endTime ??
                          _parseTimeString(data.endTime),
                      onTimeSelected: (newTime) {
                        changeTimingProvider.setEndTime(newTime);
                      },
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
              14.horizontalSpace,
              ChangeTimingChips(),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  DateTime? _parseTimeString(String timeString) {
    try {
      DateTime dt = DateFormat.Hm().parse(timeString, true);
      return dt.add(Duration(hours: 0));
    } catch (e) {
      return null;
    }
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

          DateTime utc4Time = selectedDateTime.toUtc();

          onTimeSelected(utc4Time);
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
                      ? DateFormat.jm().format(
                          selectedTime.toUtc().add(
                                Duration(hours: 4),
                              ),
                        )
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
