import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/add-language-pair/cubit/add_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/add-language-pair/view/add_language_pair_list.dart';

class AddLanguagePairBody extends StatelessWidget {
  const AddLanguagePairBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddLanguagePairCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final languagePairs = state.data;
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0).r,
              child: Column(
                children: [
                  AddLanguagePairList(
                    languagePairs: languagePairs,
                  ),
                ],
              ),
            ),
          );
        } else if (state is FailureState) {
          return Center(child: Text('Failed to load languages'));
        } else {
          return Center(child: Text('Initializing...'));
        }
      },
    );
  }
}
