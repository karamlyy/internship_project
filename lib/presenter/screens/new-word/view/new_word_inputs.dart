import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/presenter/screens/new-word/cubit/new_word_cubit.dart';
import 'package:language_learning/presenter/screens/new-word/provider/new_word_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';



class NewWordInputs extends StatelessWidget {
  const NewWordInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final newWordProvider = context.watch<NewWordProvider>();
    final newWordCubit = context.read<NewWordCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<List<LanguagePairModel>>(
                    stream: context.read<NewWordCubit>().languagePairController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const PrimaryText(
                          text: 'Failed to load',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      } else if (snapshot.hasData) {
                        final languagePairs = snapshot.data!;
                        final selectedPair =
                            newWordProvider.selectedLanguagePair ??
                                newWordProvider
                                    .getSelectedLanguagePair(languagePairs);
                        final isSwapped = selectedPair?.isSwapped ?? false;
                        return PrimaryText(
                          text: isSwapped ? selectedPair?.translationLanguage : selectedPair?.sourceLanguage,
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      } else {
                        return const PrimaryText(
                          text: 'No data available',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      }
                    },
                  ),
                  PrimaryTextFormField(
                    initialText: newWordProvider.word,
                    onChanged: (value) =>
                        newWordProvider.updateWord(value.trim()),
                    isFilled: false,
                    defaultBorderColor: Colors.transparent,
                    defaultEnabledBorderColor: Colors.transparent,
                    defaultFocusedBorderColor: Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10).r,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<List<LanguagePairModel>>(
                    stream: context.read<NewWordCubit>().languagePairController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const PrimaryText(
                          text: 'Failed to load',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      } else if (snapshot.hasData) {
                        final languagePairs = snapshot.data!;
                        final selectedPair = newWordProvider.selectedLanguagePair ?? newWordProvider.getSelectedLanguagePair(languagePairs);
                        final isSwapped = selectedPair?.isSwapped ?? false;
                        return PrimaryText(
                          text: isSwapped ? selectedPair?.sourceLanguage : selectedPair?.translationLanguage,

                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      } else {
                        return const PrimaryText(
                          text: 'No data available',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'Inter',
                        );
                      }
                    },
                  ),
                  PrimaryTextFormField(
                    initialText: newWordProvider.translation,
                    onChanged: (value) =>
                        newWordProvider.updateTranslation(value.trim()),
                    isFilled: false,
                    defaultBorderColor: Colors.transparent,
                    defaultEnabledBorderColor: Colors.transparent,
                    defaultFocusedBorderColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          16.verticalSpace,
          Column(
            children: [
              CupertinoButton(
                pressedOpacity: 1,
                padding: EdgeInsets.zero,
                onPressed: () {
                  newWordProvider.addLearning(!newWordProvider.isLearningNow);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    children: [
                      PrimaryText(
                        haveUnderline: TextDecoration.underline,
                        text: L10n.addToLearning,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      12.horizontalSpace,
                      Icon(
                        newWordProvider.isLearningNow
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: AppColors.primary,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ),

              CupertinoButton(
                pressedOpacity: 1,
                padding: EdgeInsets.zero,
                onPressed: () {
                   newWordCubit.downloadTemplate();
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    children: [
                       PrimaryText(
                        haveUnderline: TextDecoration.underline,
                        text: L10n.downloadTemplate,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      12.horizontalSpace,
                      Icon(
                        Icons.download,
                        color: AppColors.primary,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
