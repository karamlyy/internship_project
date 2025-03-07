import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary-ai/cubit/vocabulary_ai_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary-ai/view/vocabulary_ai_body.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/provider/vocabulary_provider.dart';
import 'package:language_learning/presenter/screens/vocabulary/view/vocabulary_body.dart';
import 'package:language_learning/presenter/screens/story/view/bottom_floating_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/primary_text_form_field.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';


class VocabularyAiPage  extends StatelessWidget {
  const VocabularyAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VocabularyAiCubit(),
      child: ChangeNotifierProvider(
        create: (context) => VocabularyProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: 'AI Vocabulary',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'Inter',
            ),
          ),
          body: BlocListener<VocabularyAiCubit, BaseState>(
            listener: (context, state) {},
            child: Stack(children: [
              VocabularyAiBody(),
              BottomFloatingButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
