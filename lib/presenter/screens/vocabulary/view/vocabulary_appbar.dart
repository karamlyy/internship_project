import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class VocabularyAppbar extends StatelessWidget {
  const VocabularyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Builder(
        builder: (context) {
          final vocabularyProvider = context.watch<VocabularyProvider>();
          return vocabularyProvider.isSearchActive
              ? TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(fontSize: 14.sp),
                    filled: true,
                    fillColor: AppColors.error,
                    suffix: TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        'clear',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14.sp,
                  ),
                )
              : const PrimaryText(
                  text: 'Vocabulary',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSerifDisplay',
                  fontSize: 20,
                );
        },
      ),
      actions: [
        Builder(
          builder: (context) {
            final vocabularyProvider = context.watch<VocabularyProvider>();
            return IconButton(
              onPressed: () {
                vocabularyProvider.toggleSearch();
              },
              icon: Icon(
                vocabularyProvider.isSearchActive
                    ? Icons.close
                    : CupertinoIcons.search,
                size: 20.w,
              ),
            );
          },
        ),
      ],
    );
  }
}
