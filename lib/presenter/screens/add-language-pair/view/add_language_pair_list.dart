import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/presenter/screens/add-language-pair/cubit/add_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class AddLanguagePairList extends StatelessWidget {
  final List<LanguagePairModel> languagePairs;

  const AddLanguagePairList({
    super.key,
    required this.languagePairs,
  });

  @override
  Widget build(BuildContext context) {
    final addLanguagePairCubit = context.watch<AddLanguagePairCubit>();
    final homeCubit = context.read<HomeCubit>();

    return Expanded(
      child: ListView.builder(
        itemCount: languagePairs.length,
        itemBuilder: (context, index) {
          final languagePair = languagePairs[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.w,
              vertical: 5.h,
            ),
            child: Dismissible(
              key: ValueKey(languagePair.id),
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.r),
                  color: AppColors.error,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: Icon(
                        CupertinoIcons.delete,
                        color: AppColors.itemBackground,
                        size: 20.w,
                      ),
                    )
                  ],
                ),
              ),
              confirmDismiss: (direction) async {
                if (languagePair.isSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cannot dismiss a selected language pair'),
                    ),
                  );
                  return false;
                }
                if (direction == DismissDirection.startToEnd) {
                  bool? confirmDeletion =
                      await showDeleteConfirmationDialog(context);
                  if (confirmDeletion ?? false) {
                    await addLanguagePairCubit
                        .deleteLanguagePair(languagePair.id);
                    homeCubit.setSelectedLanguagePair(languagePair.id);
                    homeCubit.getAllLanguagePairs();
                    homeCubit.getCardCounts();
                    homeCubit.getLastWords();

                  }
                  return false;
                }
                return false;
              },
              child: ListTile(
                onTap: () async {
                  await addLanguagePairCubit
                      .setSelectedLanguagePair(languagePair.id);
                  homeCubit.setSelectedLanguagePair(languagePair.id);
                  homeCubit.getLastWords();
                  homeCubit.getCardCounts();
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                tileColor: languagePair.isSelected
                    ? AppColors.itemBackground
                    : AppColors.unselectedItemBackground,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24).r,
                  borderSide: BorderSide(
                      color: languagePair.isSelected
                          ? AppColors.itemBorder
                          : Colors.transparent),
                ),
                title: PrimaryText(
                  text:
                      '${languagePair.sourceLanguage} - ${languagePair.translationLanguage}',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: PrimaryText(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            text: "Confirm Deletion",
            fontFamily: 'Inter',
          ),
          content: Text("Are you sure you want to delete this language pair?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
