import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_footer.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_form.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_header.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_helper_buttons.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10).r,
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(Images.registerBackground),
                  fit: BoxFit.cover,
                ),
                borderRadius:
                BorderRadius.circular(isKeyboardVisible ? 12 : 32).r,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const RegisterHeader(),
                        const RegisterForm(),
                        16.verticalSpace,
                        const RegisterHelperButtons(),
                      ],
                    ),
                  ),
                  const RegisterFooter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}