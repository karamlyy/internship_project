import 'package:flutter/material.dart';

import 'onboarding_buttons.dart';
import 'onboarding_header.dart';
import 'onboarding_text.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          OnboardingHeader(),
          OnboardingText(),
          OnboardingButtons(),
        ],
      ),
    );
  }
}
