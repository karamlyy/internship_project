import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/data/service/voice-service/voice_service.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:provider/provider.dart';

class VocabularyWordsList extends StatelessWidget {
  const VocabularyWordsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final vocabularyProvider = context.watch<VocabularyProvider>();
    final vocabularyCubit = context.read<VocabularyCubit>();

    final VoiceService voiceService = VoiceService();

    return BlocBuilder<VocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final data = state.data;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0).r,
                child: Consumer<VocabularyProvider>(
                  builder: (context, provider, child) {
                    return CupertinoSlidingSegmentedControl<int>(
                      thumbColor: AppColors.primary,
                      backgroundColor: AppColors.unselectedItemBackground,
                      padding: EdgeInsets.all(8).r,
                      groupValue: provider.selectedSegmentIndex,
                      onValueChanged: (int? newIndex) {
                        if (newIndex != null) {
                          provider.updateSegmentIndex(newIndex);
                          context
                              .read<VocabularyCubit>()
                              .filterWordsBySegment(newIndex);
                        }
                      },
                      children: {
                        0: Padding(
                          padding: EdgeInsets.all(10).r,
                          child: Text('All words'),
                        ),
                        1: Padding(
                          padding: EdgeInsets.all(10).r,
                          child: Text('Learning'),
                        ),
                        2: Padding(
                          padding: EdgeInsets.all(10).r,
                          child: Text('None learning'),
                        ),
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final vocabularyCubit = context.read<VocabularyCubit>();
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
                      child: Dismissible(
                        key: UniqueKey(),
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
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            color: AppColors.primaryText.withValues(alpha: 0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: Icon(
                                  CupertinoIcons.pencil,
                                  color: AppColors.itemBackground,
                                  size: 20.w,
                                ),
                              )
                            ],
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          final vocabularyCubit =
                              context.read<VocabularyCubit>();
                          final homeCubit = context.read<HomeCubit>();

                          if (direction == DismissDirection.startToEnd) {
                            bool? confirmDeletion =
                                await _showDeleteWordConfirmationDialog(
                                    context);

                            if (confirmDeletion == true) {
                              await vocabularyCubit.deleteWord(word.id);
                              homeCubit.getLastWords();
                              homeCubit.getCardCounts();
                              return true;
                            }
                            return false;
                          }

                          if (direction == DismissDirection.endToStart) {
                            _showUpdateDialog(context, vocabularyCubit, word);
                            return false;
                          }

                          return false;
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 2.h,
                          ),
                          tileColor: AppColors.unselectedItemBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            side: BorderSide(color: Colors.transparent),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                //onPressed: () => _speak(word.translation),
                                onPressed: () => voiceService.flutterTts
                                    .speak(word.translation),
                                icon: Icon(
                                  CupertinoIcons.volume_up,
                                  size: 20.w,
                                  color: AppColors.bookMarkBackground,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await vocabularyCubit.addToLearning(word.id);
                                  vocabularyProvider.changeWordStatus(
                                      data, index);
                                  homeCubit.getLastWords();
                                  homeCubit.getCardCounts();
                                },
                                icon: Icon(
                                  word.isMastered
                                      ? Icons.bookmark
                                      : word.isLearningNow
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                  size: 20.w,
                                  color: word.isMastered
                                      ? AppColors.primary
                                      : word.isLearningNow
                                          ? AppColors.primary.withOpacity(0.5)
                                          : AppColors.bookMarkBackground,
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
                      ),
                    );
                  },
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  bool? confirmDeletion =
                      await _showDeleteAllWordsConfirmationDialog(context);
                  if (confirmDeletion == true) {
                    await vocabularyCubit.deleteAllWords();
                    homeCubit.getCardCounts();
                    homeCubit.getLastWords();
                  } else {}
                },
                child: Icon(
                  Icons.delete,
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

  Future<bool?> _showDeleteWordConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: PrimaryText(
            text: "Confirm Deletion",
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
          content: Text("Are you sure you want to delete this word?"),
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

  Future<bool?> _showDeleteAllWordsConfirmationDialog(
      BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: PrimaryText(
            text: "Confirm Deletion",
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
          content: Text("Are you sure you want to delete all words?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete All"),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(
      BuildContext context, VocabularyCubit cubit, dynamic word) {
    final TextEditingController sourceController =
        TextEditingController(text: word.source);
    final TextEditingController translationController =
        TextEditingController(text: word.translation);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: PrimaryText(
            text: L10n.updateWords,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextFormField(
                onChanged: (value) {},
                controller: sourceController,
                headText: 'Source word',
              ),
              PrimaryTextFormField(
                onChanged: (value) {},
                controller: translationController,
                headText: 'Translation',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final homeCubit = context.read<HomeCubit>();
                await cubit.updateWord(
                  UpdateWordInput(
                    id: word.id,
                    source: sourceController.text,
                    translation: translationController.text,
                  ),
                );
                homeCubit.getLastWords();
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
