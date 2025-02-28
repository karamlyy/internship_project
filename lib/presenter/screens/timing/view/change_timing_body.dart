import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/settings/time_interval_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_button.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_chips.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_form.dart';

class ChangeTimingBody extends StatelessWidget {
  const ChangeTimingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeTimingCubit, BaseState>(
      builder: (context, state) {
        if(state is LoadingState){
          return const Center(child: CircularProgressIndicator());
        } else if(state is SuccessState){
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ChangeTimingForm(),
                        ChangeTimingChips(),
                      ],
                    ),
                  ),
                  ChangeTimingButton(),
                ],
              ),
            ),
          );
        } else if(state is FailureState){
          return const Center(child: Text('Failed to load languages'));
        } else {
          return const Center(child: Text('Initializing...'));
        }

      }
    );


  }
}
