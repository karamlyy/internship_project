import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/add-language-pair/cubit/add_language_pair_cubit.dart';
import 'package:language_learning/presenter/screens/add-language-pair/provider/add_language_pair_provider.dart';
import 'package:language_learning/presenter/screens/add-language-pair/view/add_language_pair_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';

class AddLanguagePairPage extends StatelessWidget {
  const AddLanguagePairPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddLanguagePairCubit()..getAllLanguagePairs(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigation.pushReplacementNamed(
                  Routes.createLanguagePair,
                );
              },
              icon: Icon(
                Icons.add,
                color: AppColors.primary,
                size: 26.w,
              ),
            ),
          ],
          title: PrimaryText(
            text: L10n.languages,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'Inter',
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => AddLanguagePairProvider(),
          child: BlocListener<AddLanguagePairCubit, BaseState>(
            listener: (context, state) {},
            child: AddLanguagePairBody(),
          ),
        ),
      ),
    );
  }
}
