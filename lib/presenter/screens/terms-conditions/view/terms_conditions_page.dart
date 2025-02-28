import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/terms-conditions/view/terms_conditions_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: 'Terms and Conditions',
          color: AppColors.primaryText,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          fontFamily: 'DMSerifDisplay',
        ),
      ),
      body: TermsConditionsBody(),
    );
  }
}
