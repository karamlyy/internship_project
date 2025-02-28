import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/primary_footer.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryFooter(
      onTap: () {
        Navigation.push(Routes.register);
      },
      mainText: 'Sign up',
      secondaryText: 'Dont have an account? ',
    );
  }
}