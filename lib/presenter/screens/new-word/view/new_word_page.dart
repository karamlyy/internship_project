import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_listener.dart';
import 'package:language_learning/presenter/screens/new-word/cubit/new_word_cubit.dart';
import 'package:language_learning/presenter/screens/new-word/provider/new_word_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

import 'new_word_body.dart';


class NewWordPage extends StatelessWidget {
  const NewWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewWordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'New word',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'DMSerifDisplay',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => NewWordProvider(),
          child: GenericListener<NewWordCubit, BaseState>(
            listener: (context, state) {},
            child: NewWordBody(),
          ),
        ),
      ),
    );
  }
}
