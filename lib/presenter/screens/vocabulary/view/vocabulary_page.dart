import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VocabularyCubit(),
      child: ChangeNotifierProvider(
        create: (context) => VocabularyProvider(),
        child: Scaffold(
          appBar: AppBar(
            leading: Consumer<VocabularyProvider>(
              builder: (context, provider, child) {
                return Visibility(
                  visible: true,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColors.primaryText),
                    onPressed: provider.isSearchActive
                        ? provider.toggleSearch
                        : Navigation.pop,
                  ),
                );
              },
            ),
            title: Consumer<VocabularyProvider>(
              builder: (context, provider, child) {
                final vocabularyCubit = context.watch<VocabularyCubit>();

                return provider.isSearchActive
                    ? TextField(
                        controller: provider.searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryText,
                        ),
                        onChanged: (query) {
                          provider.onSearchChanged(query, (word) {
                            vocabularyCubit.searchWord(word);
                          });
                        },
                      )
                    : PrimaryText(
                        text: 'Vocabulary',
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 20,
                      );
              },
            ),
            actions: [
              Consumer<VocabularyProvider>(
                builder: (context, provider, child) {
                  return provider.isSearchActive
                      ? TextButton(
                          onPressed: () {
                            provider.clearSearch();
                            context.read<VocabularyCubit>().getAllWords();
                          },
                          child: PrimaryText(
                            text: 'clear',
                            color: AppColors.primaryText.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.search,
                            color: AppColors.primaryText,
                            size: 20.w,
                          ),
                          onPressed: provider.toggleSearch,
                        );
                },
              ),
            ],
          ),
          body: BlocListener<VocabularyCubit, BaseState>(
            listener: (context, state) {},
            child: VocabularyWordsBody(),
          ),
        ),
      ),
    );
  }
}

class VocabularyWordsBody extends StatelessWidget {
  const VocabularyWordsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: VocabularyWordsList(),
            ),
          );
        } else if (state is FailureState) {
          return Center(
            child: Text(
              'Failed to load vocabulary data: ${state.errorMessage}',
            ),
          );
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}

class VocabularyWordsList extends StatelessWidget {
  const VocabularyWordsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final vocabularyProvider = context.watch<VocabularyProvider>();

    final FlutterTts flutterTts = FlutterTts();

    Future<void> _initializeTTS() async {
      try {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.setLanguage("en-US");

        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);
      } catch (e) {
        print("TTS Initialization Error: $e");
      }
    }

    Future<void> _speak(String text) async {
      try {
        await _initializeTTS();
        await flutterTts.speak(text);
      } catch (e) {
        print("Error in TTS: $e");
      }
    }

    return BlocBuilder<VocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final data = state.data;
          return ListView.builder(
            itemCount: data.items.length,
            itemBuilder: (context, index) {

              final vocabularyCubit = context.read<VocabularyCubit>();
              final word = data.items[index];
              final selectedPair = vocabularyProvider.selectedLanguagePair ??
                  (homeCubit.state is SuccessState
                      ? vocabularyProvider.getSelectedLanguagePair((homeCubit.state as SuccessState).data)
                      : null);
              print('is swapped: ${selectedPair?.isSwapped.toString()}');

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
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
                    if (direction == DismissDirection.startToEnd) {
                      await vocabularyCubit.deleteWord(word.id);
                      homeCubit.getLastWords();
                      homeCubit.getCardCounts();
                      return true;
                    }
                    if (direction == DismissDirection.endToStart) {
                      _showUpdateDialog(context, vocabularyCubit, word);
                      return false;
                    }
                    return false;
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                    tileColor: AppColors.unselectedItemBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      side: BorderSide(color: Colors.transparent),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _speak(word.translation),
                          icon: Icon(
                            CupertinoIcons.volume_up,
                            size: 20.w,
                            color: AppColors.bookMarkBackground,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await vocabularyCubit.addToLearning(word.id);
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
                      text: selectedPair!.isSwapped ? '${word.translation} - ${word.source}': '${word.source} - ${word.translation}',
                      fontSize: 16,
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('yuklenir'));
        }
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
            text: "Update Word",
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'DMSerifDisplay',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextFormField(
                onChanged: (value) {

                },
                controller: sourceController,
                headText: 'Source word',
              ),
              PrimaryTextFormField(
                onChanged: (value) {

                },
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
