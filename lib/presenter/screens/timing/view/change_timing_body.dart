import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_button.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_form.dart';

class ChangeTimingBody extends StatelessWidget {
  const ChangeTimingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                ChangeTimingForm(),
              ],
            ),
          ),
          ChangeTimingButton(),
        ],
      ),
    );
  }
}
