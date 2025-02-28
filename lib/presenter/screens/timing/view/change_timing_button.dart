import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class ChangeTimingButton extends StatelessWidget {
  const ChangeTimingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTimingProvider = context.watch<ChangeTimingProvider>();
    final changeTimingCubit = context.read<ChangeTimingCubit>();
    return BlocBuilder<ChangeTimingCubit, BaseState>(
      builder: (context, state) {
        if(state is LoadingState){
          return const CircularProgressIndicator();
        }
        return PrimaryButton(
          title: 'Change',
          hasBorder: false,
          isActive: changeTimingProvider.isFormValid,
          onTap: () {
            changeTimingCubit.changeTiming(changeTimingProvider.timingInput);
          },
        );
      },
    );
  }
}
