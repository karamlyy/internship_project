import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

import '../../vocabulary/provider/vocabulary_provider.dart';
import 'story_page.dart';

class BottomFloatingButton extends StatelessWidget {
  const BottomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 80.w,
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
                width: 64.w,
                height: 64.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    final vocabularyProvider = context.read<VocabularyProvider>();

                    if (vocabularyProvider.selectedWords.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoryPage(selectedWords: vocabularyProvider.selectedWords, prompt: vocabularyProvider.prompt)
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select at least one word')),
                      );
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.sparkles,
                    color: Colors.white,
                    size: 34.w,
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
