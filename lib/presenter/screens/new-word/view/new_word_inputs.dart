import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';



class NewWordInputs extends StatelessWidget {
  const NewWordInputs({super.key});

  void downloadTemplate(BuildContext context) async {
    const String fileUrl = 'https://raw.githubusercontent.com/karamlyy/db/main/VocabularyTemplate.xlsx';
    const String fileName = 'VocabularyTemplate.xlsx';

    try {
      Directory? directory = await getDownloadDirectory();

      if (directory == null) {
        print('Failed to get download directory');
        return;
      }

      String filePath = '${directory.path}/$fileName';

      Dio dio = Dio();
      await dio.download(fileUrl, filePath);

      print( 'Downloaded to $filePath');
    } catch (e) {
      debugPrint('Download failed: $e');
      print('Failed to download file');
    }
  }

  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final newWordProvider = context.watch<NewWordProvider>();
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
                          fontFamily: 'DMSerifDisplay',
                        );
                      } else if (snapshot.hasData) {
                        final languagePairs = snapshot.data!;
                        final selectedPair =
                            newWordProvider.selectedLanguagePair ??
                                newWordProvider
                                    .getSelectedLanguagePair(languagePairs);
                        return PrimaryText(
                          text: selectedPair?.sourceLanguage ??
                              'No source language',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'DMSerifDisplay',
                        );
                      } else {
                        return const PrimaryText(
                          text: 'No data available',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'DMSerifDisplay',
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
                          fontFamily: 'DMSerifDisplay',
                        );
                      } else if (snapshot.hasData) {
                        final languagePairs = snapshot.data!;
                        final selectedPair =
                            newWordProvider.selectedLanguagePair ??
                                newWordProvider
                                    .getSelectedLanguagePair(languagePairs);
                        return PrimaryText(
                          text: selectedPair?.translationLanguage ??
                              'No translation language',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'DMSerifDisplay',
                        );
                      } else {
                        return const PrimaryText(
                          text: 'No data available',
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          fontFamily: 'DMSerifDisplay',
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
                      const PrimaryText(
                        haveUnderline: TextDecoration.underline,
                        text: 'Add to Learning',
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
                  downloadTemplate(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    children: [
                      const PrimaryText(
                        haveUnderline: TextDecoration.underline,
                        text: 'Download template',
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
