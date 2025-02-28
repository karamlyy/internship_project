import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class Header extends StatelessWidget {
  final VoidCallback? onTap;

  const Header({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap ?? () => Navigation.pushNamedAndRemoveUntil(Routes.login),
            child: Ink(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(
                  color: AppColors.itemBorder,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primaryText,
                size: 20.h,
              ),
            ),
          ),
          Image.asset(
            'assets/images/smallstar.png',
            width: 53.w,
            height: 53.w,
          ),
        ],
      ),
    );
  }
}
