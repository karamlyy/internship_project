import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final int? id;
  final String? groupName;
  final int? allWords;
  final int? masteredWords;
  final String? image;

  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    this.id,
    this.groupName,
    this.allWords,
    this.masteredWords,
    this.image,
    this.onTap,
  });

  Widget _buildCategoryImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return SizedBox(
        width: 56.w,
        height: 56.h,
        child: Icon(Icons.language, size: 30, color: Colors.grey),
      );
    }

    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        width: 56.w,
        height: 56.h,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return const SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          Icons.broken_image,
          size: 30,
          color: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0).r,
        ),
        color: AppColors.unselectedItemBackground,

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryText(
                        text: groupName,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: 'DMSerifDisplay',
                      ),
                      PrimaryText(
                        text: 'Mastered $masteredWords of $allWords',
                        color: AppColors.primaryText.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  12.horizontalSpace,
                  _buildCategoryImage(image)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
