import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_cubit.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_state.dart';
import 'package:language_learning/presenter/screens/create-language-pair/cubit/create_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/create-language-pair/provider/create_language_provider.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';


class CreateLanguagePairButton extends StatelessWidget {
  const CreateLanguagePairButton({super.key});

  @override
  Widget build(BuildContext context) {
    final languageCubit = context.read<CreateLanguagePairCubit>();
    final languagesProvider = context.watch<CreateLanguageProvider>();

    final homeCubit = context.read<HomeCubit>();


    return GenericBuilder<CreateLanguagePairCubit, BaseState>(
      builder: (context, state) {


        return PrimaryButton(
          title: 'Confirm',
          hasBorder: false,
          isActive: (languagesProvider.isSourceLanguageSelected &&
              languagesProvider.isTranslationLanguageSelected) &&
              (languagesProvider.selectedSourceLanguageId !=
                  languagesProvider.selectedTranslationLanguageId),
          onTap: () async {
            if (languagesProvider.isSourceLanguageSelected) {
              if (languagesProvider.isTranslationLanguageSelected) {
                await languageCubit.setLanguage(languagesProvider.setLanguageInput);
                homeCubit.getAllLanguagePairs();
              }
            }
          },
        );
      },
    );
  }
}
