import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_learning/utils/asset-paths/app_assets.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class SecondaryFloatingBottomNavbar extends StatelessWidget {
  const SecondaryFloatingBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 212.w,
          padding: EdgeInsets.symmetric(vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
              image: AssetImage('assets/images/buttonBg.png'),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    // Handle Home tap
                  },
                  icon: Icon(
                    Icons.home_filled,
                    color: AppColors.primary,
                    size: 24.w,
                  ),
                ),
              ),
              30.horizontalSpace,
              Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigation.push(Routes.newWord);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28.w,
                  ),
                ),
              ),
              30.horizontalSpace,
              Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigation.push(Routes.settings).then((onValue) {

                    });
                  },
                  icon: Icon(
                    Icons.settings_rounded,
                    color: AppColors.primary,
                    size: 24.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
