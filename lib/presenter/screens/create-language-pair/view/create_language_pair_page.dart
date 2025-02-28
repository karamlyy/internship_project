import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_listener.dart';
import 'package:language_learning/presenter/screens/auth/languages/cubit/language_cubit.dart';
import 'package:language_learning/presenter/screens/auth/languages/provider/languages_provider.dart';
import 'package:language_learning/presenter/screens/create-language-pair/cubit/create_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/create-language-pair/provider/create_language_provider.dart';
import 'package:language_learning/presenter/screens/create-language-pair/view/create_language_pair_body.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class CreateLanguagePairPage extends StatelessWidget {
  const CreateLanguagePairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLanguagePairCubit()..getAllLanguages(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'Languages',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'DMSerifDisplay',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => CreateLanguageProvider(),
          child: GenericListener<CreateLanguagePairCubit, BaseState>(
            listener: (context, state) {},
            child: CreateLanguagePairBody(),
          ),
        ),
      ),
    );
  }
}
