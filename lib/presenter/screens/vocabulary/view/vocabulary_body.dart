import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
import 'package:language_learning/presenter/screens/vocabulary/view/vocabulary_list.dart';

class VocabularyWordsBody extends StatelessWidget {
  const VocabularyWordsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabularyCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        } else if (state is SuccessState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              //child: VocabularyWordsList(),
            ),
          );
        } else if (state is FailureState) {
          return Center(
            child: Text(
              'Failed to load home data: ${state.errorMessage}',
            ),
          );
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}
