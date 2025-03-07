import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary-ai/cubit/vocabulary_ai_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class VocabularyAiList extends StatelessWidget {
  const VocabularyAiList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final vocabularyProvider = context.watch<VocabularyProvider>();

    return BlocBuilder<VocabularyAiCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final data = state.data as List<WordPairModel>;
          return Column(
            children: [
              PrimaryTextFormField(

                hint: 'Enter prompt to generate story based on this prompt',
                onChanged: vocabularyProvider.updateUserPrompt,
                suffixIcon: Icon(CupertinoIcons.sparkles),
                isObscureText: false,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final word = data[index];
                    final selectedPair =
                        vocabularyProvider.selectedLanguagePair ??
                            (homeCubit.state is SuccessState
                                ? vocabularyProvider.getSelectedLanguagePair(
                                    (homeCubit.state as SuccessState).data)
                                : null);

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 0.h),
                        tileColor: AppColors.unselectedItemBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              word.isMastered ? Icons.bookmark : Icons.bookmark,
                              color: word.isMastered
                                  ? AppColors.primary
                                  : word.isLearningNow
                                      ? AppColors.primary.withValues(alpha: 0.6)
                                      : AppColors.primary
                                          .withValues(alpha: 0.1),
                            ),
                            12.horizontalSpace,
                            Checkbox(
                              value: vocabularyProvider.selectedWords
                                  .contains(word),
                              onChanged: (isChecked) {
                                vocabularyProvider.toggleWordSelection(word);
                              },
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              activeColor: AppColors.background,
                              checkColor: AppColors.primary,
                              side: BorderSide(
                                width: 1.0,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        title: PrimaryText(
                          text: selectedPair!.isSwapped
                              ? '${word.translation} - ${word.source}'
                              : '${word.source} - ${word.translation}',
                          fontSize: 16,
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('yuklenir'));
        }
      },
    );
  }
}
