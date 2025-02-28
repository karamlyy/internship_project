import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/primary_footer.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryFooter(
      onTap: () {
        Navigation.pushReplacementNamed(
          Routes.login,
        );
      },
      mainText: 'Sign in',
      secondaryText: 'Already have an account? ',
    );
  }
}