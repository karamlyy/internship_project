import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class ListCard extends StatelessWidget {
  final int id;
  final String listName;
  final bool isActive;
  final VoidCallback onTap;

  const ListCard({
    super.key,
    required this.id,
    required this.listName,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: isActive
              ? AppColors.itemBackground
              : AppColors.unselectedItemBackground,
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/list_star.svg', width: 20.w,),
            10.horizontalSpace,
            PrimaryText(
              text: listName,
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }
}
