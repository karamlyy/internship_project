import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/auth/timing/cubit/timing_cubit.dart';
import 'package:language_learning/presenter/screens/auth/timing/provider/timing_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';

class TimingButton extends StatelessWidget {
  const TimingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final timingProvider = context.watch<TimingProvider>();
    final timingCubit = context.read<TimingCubit>();
    return BlocBuilder<TimingCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: EdgeInsets.only(left: 16.r, right: 16.r, bottom: 24.r),
          child: PrimaryButton(
            title: 'Continue',
            hasBorder: false,
            isActive: timingProvider.isSelectedInterval(),
            onTap: () async {
              timingCubit.setTiming(context, timingProvider.timingInput);
            },
          ),
        );
      },
    );
  }
}
