import 'package:flutter/material.dart';
import 'package:language_learning/presenter/widgets/primary_header.dart';

import 'forgot_password_footer.dart';
import 'forgot_password_form.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: ListView(
              children: const [
                ForgotPasswordForm(),
              ],
            ),
          ),
          const ForgotPasswordFooter(),
        ],
      ),
    );
  }
}