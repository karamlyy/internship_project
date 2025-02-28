import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/auth/timing/cubit/timing_cubit.dart';
import 'package:language_learning/presenter/screens/auth/timing/provider/timing_provider.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_button.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_form.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_interval_chips.dart';
import 'package:language_learning/presenter/widgets/primary_header.dart';

class TimingBody extends StatelessWidget {
  const TimingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final timingProvider = context.watch<TimingProvider>();

    return BlocBuilder<TimingCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final chips = state.data as List<TimeIntervalModel>;

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TimingForm(),
                      TimingIntervalChips(
                        intervalChips: chips,
                        selectedIntervalId: timingProvider.selectedIntervalId,
                        onIntervalSelected: (id) {
                          timingProvider.selectInterval(id);
                        },
                      ),
                      const TimingButton(),
                    ],
                  ),
                )
              ],
            ),
          );
        } else if (state is FailureState) {
          return const Center(child: Text('Failed to load languages'));
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}
