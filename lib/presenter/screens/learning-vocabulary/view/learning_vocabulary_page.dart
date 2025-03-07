import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/learning-vocabulary/cubit/learning_vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/learning-vocabulary/provider/learning_vocabulary_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:provider/provider.dart';

class LearningVocabularyPage extends StatelessWidget {
  const LearningVocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LearningVocabularyCubit(),
      child: ChangeNotifierProvider(
        create: (context) => LearningVocabularyProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: L10n.learningVocabulary,
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              fontSize: 20,
            ),
          ),
          body: BlocListener<LearningVocabularyCubit, BaseState>(
            listener: (context, state) {},
            child: LearningVocabularyBody(),
          ),
        ),
      ),
    );
  }
}

class LearningVocabularyBody extends StatelessWidget {
  const LearningVocabularyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningVocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: LearningVocabularyList(),
            ),
          );
        } else if (state is FailureState) {
          return Center(
            child: Text(
              'Failed to load home data: ${state.errorMessage}',
            ),
          );
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}

class LearningVocabularyList extends StatelessWidget {
  const LearningVocabularyList({super.key});

  @override
  Widget build(BuildContext context) {
    final learningVocabularyCubit = context.watch<LearningVocabularyCubit>();
    final homeCubit = context.read<HomeCubit>();
    final learningVocabularyProvider = context.watch<LearningVocabularyProvider>();


    return BlocBuilder<LearningVocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final data = state.data;
          return ListView.builder(
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              final selectedPair = learningVocabularyProvider.selectedLanguagePair ??
                  (homeCubit.state is SuccessState
                      ? learningVocabularyProvider.getSelectedLanguagePair((homeCubit.state as SuccessState).data)
                      : null);
              print('is swapped: ${selectedPair?.isSwapped.toString()}');
              final word = data.items[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.w,
                  vertical: 5.h,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                  tileColor: AppColors.unselectedItemBackground,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  trailing: IconButton(
                    onPressed: ()  async {
                      await learningVocabularyCubit.addToLearning(word.id);
                      homeCubit.getCardCounts();
                    },
                    icon: Icon(
                      word.isLearningNow
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      size: 20.w,
                      color: AppColors.bookMarkBackground,
                    ),
                  ),
                  title: PrimaryText(
                    text: selectedPair!.isSwapped ? '${word.translation} - ${word.source}': '${word.source} - ${word.translation}',

                    fontSize: 16,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
