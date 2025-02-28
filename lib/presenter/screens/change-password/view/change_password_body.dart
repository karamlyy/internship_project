import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/change-password/view/change_password_button.dart';
import 'package:language_learning/presenter/screens/change-password/view/change_password_form.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: const [
                  ChangePasswordForm(),
                ],
              ),
            ),
            const ChangePasswordButton(),
          ],
        ),
      ),
    );
  }
}
