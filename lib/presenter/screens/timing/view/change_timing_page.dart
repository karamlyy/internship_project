import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class ChangeTimingPage extends StatelessWidget {
  const ChangeTimingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeTimingCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'Settings',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'DMSerifDisplay',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ChangeTimingProvider(),
          child: BlocListener<ChangeTimingCubit, BaseState>(
            listener: (context, state) {},
            child: ChangeTimingBody(),
          ),
        ),
      ),
    );
  }
}
