import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_listener.dart';
import 'package:language_learning/presenter/screens/change-password/cubit/change_password_cubit.dart';
import 'package:language_learning/presenter/screens/change-password/provider/change_password_provider.dart';
import 'package:language_learning/presenter/screens/change-password/view/change_password_body.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'Password',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontFamily: 'DMSerifDisplay',
            fontSize: 20,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ChangePasswordProvider(),
          child: GenericListener<ChangePasswordCubit, BaseState>(
            listener: (context, state) {},
            child: ChangePasswordBody(),
          ),
        ),
      ),
    );
  }
}
