import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/language/language_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_cubit.dart';
import 'package:language_learning/presenter/screens/auth/languages/provider/languages_provider.dart';
import 'package:language_learning/presenter/screens/auth/languages/view/set_language_button.dart';
import 'package:language_learning/presenter/screens/auth/languages/view/set_language_header.dart';
import 'package:language_learning/presenter/screens/auth/languages/view/set_languages_list.dart';
import 'package:language_learning/presenter/widgets/primary_header.dart';

class SetLanguageBody extends StatelessWidget {
  const SetLanguageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final languagesProvider = context.watch<LanguagesProvider>();

    return BlocBuilder<LanguageCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final languages = state.data as List<LanguageModel>;

          return SafeArea(
            child: Column(
              children: [
                const Header(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SetLanguageHeader(),
                        42.verticalSpace,
                        SetLanguagesList(
                          languages: languages,
                          selectedLanguageId: languagesProvider.isSourceLanguageSelected
                              ? languagesProvider.selectedTranslationLanguageId
                              : languagesProvider.selectedSourceLanguageId,
                          onLanguageSelected: (id) {
                            if (languagesProvider.isSourceLanguageSelected) {
                              languagesProvider.selectTranslationLanguage(id);
                            } else {
                              languagesProvider.selectSourceLanguage(id);
                            }
                          },
                        ),
                        const SetLanguageButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is FailureState) {
          return const Center(child: Text('Failed to load languages'));
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}
