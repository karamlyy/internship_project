import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isKeyboardVisible ? 0.h : 200.h,
              child: SvgPicture.asset(
                Images.registerHeaderStars,
                fit: BoxFit.contain,
                //height: isKeyboardVisible ? 0.h : 200.h,
              ),
            ),
            10.verticalSpace,
            Row(
              children: [
                PrimaryText(
                  text: 'Hi, Welcome',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontSize: isKeyboardVisible ? 26 : 30,
                  fontFamily: 'DMSerifDisplay',
                ),
                7.horizontalSpace,
                Image.asset(
                  Images.registerHelloIcon,
                  fit: BoxFit.contain,
                  width: isKeyboardVisible ? 26.w : 30.w,
                  height: isKeyboardVisible ? 26.h : 30.h,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}