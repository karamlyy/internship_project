import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/view/reset_password_footer.dart';
import 'package:language_learning/presenter/screens/auth/reset-password/view/reset_password_form.dart';
import 'package:language_learning/presenter/widgets/primary_header.dart';

class ResetPasswordBody extends StatelessWidget {
  final String userId;
  final String codeExpiry;

  const ResetPasswordBody({
    super.key,
    required this.userId,
    required this.codeExpiry,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Header(),
          Expanded(
            child: ListView(
              children: const [
                ResetPasswordForm(),
              ],
            ),
          ),
          const ResetPasswordFooter(),
        ],
      ),
    );
  }
}
