import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/screens/vocabulary/view/vocabulary_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';

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
                        text: L10n.vocabulary,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
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
                            context.read<VocabularyCubit>().getAllWordsList();
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
