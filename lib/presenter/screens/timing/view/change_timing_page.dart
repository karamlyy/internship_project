import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_consumer.dart';
import 'package:language_learning/presenter/screens/timing/cubit/change_timing_cubit.dart';
import 'package:language_learning/presenter/screens/timing/provider/change_timing_provider.dart';
import 'package:language_learning/presenter/screens/timing/view/change_timing_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
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
            text: L10n.notifications,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ChangeTimingProvider(),
          child: GenericConsumer<ChangeTimingCubit, BaseState>(
            listener: (context, state) {},
            builder: (context, state) {
              if(state is SuccessState){
                return ChangeTimingBody();
              }
              return Center(child: Text("Initialize...."));
            },
          ),
        ),
      ),
    );
  }
}
