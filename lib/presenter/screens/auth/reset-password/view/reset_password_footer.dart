import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/primary_footer.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ResetPasswordFooter extends StatelessWidget {
  const ResetPasswordFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryFooter(
      onTap: () {
        Navigation.pushReplacementNamed(
          Routes.login,
        );
      },
      mainText: 'Log in',
      secondaryText: 'Already have an account? ',
    );
  }
}
