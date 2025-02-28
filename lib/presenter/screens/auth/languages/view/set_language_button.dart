import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_cubit.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_state.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';

import '../provider/languages_provider.dart';

class SetLanguageButton extends StatelessWidget {
  const SetLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<LanguageCubit>();
    final languagesProvider = context.watch<LanguagesProvider>();
    return GenericBuilder<LanguageCubit, BaseState>(
      builder: (context, state) {

        return PrimaryButton(
          title: 'Continue',
          hasBorder: false,
          isActive: (languagesProvider.isSourceLanguageSelected &&
                  languagesProvider.isTranslationLanguageSelected) &&
              (languagesProvider.selectedSourceLanguageId !=
                  languagesProvider.selectedTranslationLanguageId),
          onTap: () {
            if (languagesProvider.isSourceLanguageSelected) {
              if (languagesProvider.isTranslationLanguageSelected) {
                languageCubit.setLanguage(languagesProvider.setLanguageInput);
              }
            }
          },
        );
      },
    );
  }
}
