import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/data/model/home/user_vocabulary_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/screens/home/widgets/word_card.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class HomeWords extends StatelessWidget {
  const HomeWords({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: BlocListener<HomeCubit, BaseState>(
        listener: (context, state) {},
        child: HomeWordsList(),
      ),
    );
  }
}

class HomeWordsList extends StatelessWidget {
  const HomeWordsList({super.key});

  @override
  Widget build(BuildContext context) {

    final homeProvider = context.read<HomeProvider>();


    return StreamBuilder<UserVocabularyModel>(
      stream: context.read<HomeCubit>().lastWordsController,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(50.0).r,
              child: Center(
                child: PrimaryText(
                  text: 'You have not added words yet',
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: SizedBox(
              height: 1000,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.items.length,
                itemBuilder: (context, index) {
                  final wordPair = snapshot.data?.items[index];
                  final homeCubit = context.read<HomeCubit>();

                  final selectedPair = homeProvider.selectedLanguagePair ??
                      (homeCubit.state is SuccessState
                          ? homeProvider.getSelectedLanguagePair((homeCubit.state as SuccessState).data)
                          : null);
                  print('is swapped: ${selectedPair?.isSwapped.toString()}');
                  return WordCard(
                    id:  wordPair?.id,
                    word:  selectedPair!.isSwapped ? wordPair?.translation : wordPair?.source,
                    translation: selectedPair.isSwapped ? wordPair?.source : wordPair?.translation,
                    isAdded: wordPair?.isLearningNow,
                  );
                },
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
