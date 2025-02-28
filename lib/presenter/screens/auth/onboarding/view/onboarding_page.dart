import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/app/app_cubit.dart';
import 'package:language_learning/app/app_state.dart';

import 'onboarding_body.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: Scaffold(
        body: BlocListener<AppCubit, AppState>(
          listener: (context, state) {},
          child: const OnboardingBody(),
        ),
      ),
    );
  }
}
