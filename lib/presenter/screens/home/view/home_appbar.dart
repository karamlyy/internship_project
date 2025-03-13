import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final homeCubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, BaseState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final selectedPair = homeProvider.selectedLanguagePair ??
              homeProvider.getSelectedLanguagePair(state.data);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            child: CupertinoButton(
              onPressed: () async {
                await homeCubit.swapLanguages(selectedPair.id);
                homeCubit.getLastWords();
                homeCubit.getCardCounts();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: selectedPair!.isSwapped
                        ? '${selectedPair.translationLanguage} - ${selectedPair.sourceLanguage}'
                        : '${selectedPair.sourceLanguage} - ${selectedPair.translationLanguage}',
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,

                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.sparkles),
                        onPressed: () {
                          Navigation.push(Routes.vocabularyAI);
                        },
                        iconSize: 22.w,
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.chart_bar_alt_fill),
                        onPressed: () {
                          Navigation.push(Routes.statistics);
                        },
                        iconSize: 22.w,
                      ),

                    ],
                  )
                ],
              ),
            ),
          );
        } else if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FailureState) {
          return Center(
            child: Text(
              'Failed to load language pairs: ${state.errorMessage}',
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
