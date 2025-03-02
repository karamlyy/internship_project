import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/view/home_quiz_button.dart';
import 'package:language_learning/presenter/screens/mastered-vocabulary/cubit/mastered_vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/mastered-vocabulary/provider/mastered_vocabulary.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class MasteredVocabularyPage extends StatelessWidget {
  const MasteredVocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MasteredVocabularyCubit(),
      child: ChangeNotifierProvider(
        create: (context) => MasteredVocabularyProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: 'Mastered Vocabulary',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSerifDisplay',
              fontSize: 20,
            ),
          ),
          body: BlocListener<MasteredVocabularyCubit, BaseState>(
            listener: (context, state) {},
            child: MasteredVocabularyBody(),
          ),
          persistentFooterButtons: [
            HomeMasterQuizButton(),
          ],
        ),
      ),
    );
  }
}

class MasteredVocabularyBody extends StatelessWidget {
  const MasteredVocabularyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MasteredVocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: MasteredVocabularyList(),
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

class MasteredVocabularyList extends StatelessWidget {
  const MasteredVocabularyList({super.key});

  @override
  Widget build(BuildContext context) {
    final masteredVocabularyCubit = context.watch<MasteredVocabularyCubit>();
    final homeCubit = context.read<HomeCubit>();
    final masteredVocabularyProvider =
        context.watch<MasteredVocabularyProvider>();

    return BlocBuilder<MasteredVocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final data = state.data;
          return ListView.builder(
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              final selectedPair =
                  masteredVocabularyProvider.selectedLanguagePair ??
                      (homeCubit.state is SuccessState
                          ? masteredVocabularyProvider.getSelectedLanguagePair(
                              (homeCubit.state as SuccessState).data)
                          : null);
              print('is swapped: ${selectedPair?.isSwapped.toString()}');
              final word = data.items[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.w,
                  vertical: 5.h,
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                  tileColor: AppColors.unselectedItemBackground,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await masteredVocabularyCubit.removeFromMastered(word.id);
                      homeCubit.getCardCounts();
                      homeCubit.getLastWords();
                    },
                    icon: Icon(
                      word.isMastered ? Icons.bookmark : Icons.bookmark_outline,
                      size: 20.w,
                      color: AppColors.bookMarkBackground,
                    ),
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
