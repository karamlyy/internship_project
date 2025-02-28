import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/new-word/cubit/new_word_cubit.dart';
import 'package:language_learning/presenter/screens/new-word/provider/new_word_provider.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';


class NewWordButton extends StatelessWidget {
  const NewWordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final newWordProvider = context.watch<NewWordProvider>();
    final newWordCubit = context.read<NewWordCubit>();
    final homeCubit = context.read<HomeCubit>();

    return GenericBuilder<NewWordCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: PrimaryButton(
            title: 'Save',
            hasBorder: false,
            isActive: newWordProvider.isWordFormValid(),
            onTap: () async {
              await newWordCubit.addNewWord(newWordProvider.newWordInput);
              homeCubit.getLastWords();
              homeCubit.getCardCounts();
            },
          ),
        );
      },
    );
  }
}
