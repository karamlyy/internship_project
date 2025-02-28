import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: isKeyboardVisible ? 90.h : 165.h,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(Images.registerBackground),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(32.0).r,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10.h, bottom: 22.h),
            child: PrimaryText(
              text: L10n.signIn,
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: isKeyboardVisible ? 24 : 30,
              fontFamily: 'DMSerifDisplay',
            ),
          ),
        );
      },
    );
  }
}
