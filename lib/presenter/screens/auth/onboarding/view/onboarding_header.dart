import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              Images.loginBanner,
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
        ],
      ),
      );
  }
}
