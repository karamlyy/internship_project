import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/configuration/provider/configuration_provider.dart';
import 'package:language_learning/presenter/screens/configuration/view/configuration_body.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../cubit/configuration_cubit.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigurationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            text: 'Configuration',
            fontFamily: 'DMSerifDisplay',
            fontSize: 20,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => ConfigurationProvider(),
          child: BlocListener<ConfigurationCubit, BaseState>(
            listener: (context, state) {},
            child: ConfigurationBody(),
          ),
        ),
      ),
    );
  }
}
