import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Images.splashLogo,
        width: 200.w,
        height: 200.h,
      ),
    );
  }
}