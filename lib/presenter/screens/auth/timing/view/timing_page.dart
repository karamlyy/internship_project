import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/auth/timing/cubit/timing_cubit.dart';
import 'package:language_learning/presenter/screens/auth/timing/provider/timing_provider.dart';
import 'package:language_learning/presenter/screens/auth/timing/view/timing_body.dart';
import 'package:provider/provider.dart';

class TimingPage extends StatelessWidget {
  const TimingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimingCubit()..getAllInterval(),
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => TimingProvider(),
          child: BlocListener<TimingCubit, BaseState>(
            listener: (context, state) {},
            child: TimingBody(),
          ),
        ),
      ),
    );
  }
}
