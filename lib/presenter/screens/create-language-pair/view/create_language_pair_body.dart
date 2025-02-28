import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/language/language_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/create-language-pair/cubit/create_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/create-language-pair/provider/create_language_provider.dart';
import 'package:language_learning/presenter/screens/create-language-pair/view/create_language_list.dart';
import 'package:language_learning/presenter/screens/create-language-pair/view/create_language_pair_button.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';

class CreateLanguagePairBody extends StatelessWidget {
  const CreateLanguagePairBody({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<CreateLanguagePairCubit>();
    final languagesProvider = context.watch<CreateLanguageProvider>();


    return Padding(
      padding: const EdgeInsets.all(16.0).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              PrimaryTextFormField(
                onTap: () {
                  _showLanguagesBottomSheet(
                    context,
                    languageCubit,
                    languagesProvider,
                    isSourceLanguage: true,
                  );
                },
                hint: languagesProvider.selectedSourceLanguage ?? 'Select a native language',
                onChanged: (value) {},
                headText: 'Native',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                isReadOnly: true,
              ),

              16.verticalSpace,
              PrimaryTextFormField(
                onTap: () {
                  _showLanguagesBottomSheet(
                    context,
                    languageCubit,
                    languagesProvider,
                    isSourceLanguage: false,
                  );
                },
                hint: languagesProvider.selectedTranslationLanguage ?? 'Select a language you want to learn',
                onChanged: (value) {},
                headText: 'Learning',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                isReadOnly: true,
              ),

            ],
          ),
          const CreateLanguagePairButton(),
        ],
      ),
    );
  }

  void _showLanguagesBottomSheet(
      BuildContext context,
      CreateLanguagePairCubit languageCubit,
      CreateLanguageProvider languagesProvider, {
        required bool isSourceLanguage,
      }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<CreateLanguagePairCubit, BaseState>(
          bloc: languageCubit,
          builder: (context, state) {
            if (state is SuccessState) {
              final languages = state.data as List<LanguageModel>;

              return Padding(
                padding: const EdgeInsets.all(16.0).r,
                child: Column(
                  children: [
                    Expanded(
                      child: CreateLanguageList(
                        languages: languages,
                        selectedLanguageId: isSourceLanguage
                            ? languagesProvider.selectedSourceLanguageId
                            : languagesProvider.selectedTranslationLanguageId,
                        onLanguageSelected: (languageId) {
                          final selectedLanguage = languages.firstWhere(
                                  (lang) => lang.id == languageId,
                              orElse: () => LanguageModel(
                                  id: languageId, name: 'Unknown', image: ''));

                          if (isSourceLanguage) {
                            languagesProvider.selectSourceLanguage(languageId);
                            languagesProvider.selectSourceLanguageName(
                                selectedLanguage.name ?? 'Unknown');
                          } else {
                            languagesProvider.selectTranslationLanguage(languageId);
                            languagesProvider.selectTranslationLanguageName(
                                selectedLanguage.name ?? 'Unknown');
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FailureState) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        );
      },
    );
  }
}
