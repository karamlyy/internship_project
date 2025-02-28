import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class HomeLanguagesPairs extends StatelessWidget {
  final List<LanguagePairModel> languagePairs;
  final int? selectedLanguagePairId;
  final Function(int)? onLanguagePairSelected;
  final HomeProvider homeProvider;

  const HomeLanguagesPairs({
    super.key,
    required this.languagePairs,
    this.selectedLanguagePairId,
    this.onLanguagePairSelected,
    required this.homeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: languagePairs.length,
      itemBuilder: (context, index) {
        final languagePair = languagePairs[index];


        return GestureDetector(
          onTap: () async {
            homeProvider.setSelectedLanguagePair(languagePair);
            if (onLanguagePairSelected != null) {
              onLanguagePairSelected!(languagePair.id);
            }
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 6.h,
            ),
            padding: EdgeInsets.all(8).r,
            decoration: BoxDecoration(
              color: languagePair.isSelected
                  ? AppColors.itemBackground
                  : AppColors.unselectedItemBackground,
              borderRadius: BorderRadius.circular(8).r,
              border: Border.all(
                color: languagePair.isSelected
                    ? AppColors.itemBorder
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                16.horizontalSpace,
                PrimaryText(
                  text: '${languagePair.sourceLanguage}  -',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                12.horizontalSpace,
                PrimaryText(
                  text: languagePair.translationLanguage,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
