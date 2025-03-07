import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_listener.dart';
import 'package:language_learning/presenter/screens/settings/cubit/settings_cubit.dart';
import 'package:language_learning/presenter/screens/settings/provider/settings_provider.dart';
import 'package:language_learning/presenter/screens/settings/view/settings_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: L10n.settings
            ,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            fontSize: 20,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => SettingsProvider(),
          child: GenericListener<SettingsCubit, BaseState>(
            listener: (context, state) {},
            child: SettingsBody(),
          ),
        ),
      ),
    );
  }
}