import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/login/view/login_button.dart';
import 'package:language_learning/presenter/screens/auth/login/view/login_footer.dart';

import 'login_form.dart';
import 'login_header.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0).r,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  LoginHeader(),
                  LoginForm(),
                  LoginButton(),
                ],
              ),
            ),
            const LoginFooter()
          ],
        ),
      ),
    );
  }
}
