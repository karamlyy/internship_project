import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class WordCard extends StatelessWidget {
  final int? id;
  final String? word;
  final String? translation;
  final bool? isAdded;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const WordCard({
    super.key,
    this.id,
    this.word,
    this.translation,
    this.isAdded,
    this.onTap,
    this.onBookmarkTap,
  });

  String _truncateText(String? text, int maxLength) {
    if (text == null) return '';
    return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: AppColors.unselectedItemBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0).r,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2 .h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PrimaryText(
                    text: '${_truncateText(word, 10)} - ',
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  PrimaryText(
                    text: _truncateText(translation, 10),
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ],
              ),
              IconButton(
                onPressed: onBookmarkTap,
                icon: Icon(
                  isAdded ?? false ? Icons.bookmark : Icons.bookmark_border,
                  color: AppColors.toggleOffBackground,
                  size: 20.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
