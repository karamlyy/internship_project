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
                  ChangeTimingChipsList(),
                ],
              ),
            ),
            ChangeTimingButton(),
          ],
        ),
      ),
    );




  }
}
