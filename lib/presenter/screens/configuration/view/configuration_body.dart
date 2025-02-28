import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/settings/user_settings_model.dart';
import 'package:language_learning/presenter/screens/configuration/cubit/configuration_cubit.dart';
import 'package:language_learning/presenter/screens/configuration/provider/configuration_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../generic/base_state.dart';

class ConfigurationBody extends StatelessWidget {
  const ConfigurationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final configurationProvider = context.watch<ConfigurationProvider>();
    final configurationCubit = context.read<ConfigurationCubit>();


    return Padding(
      padding: const EdgeInsets.all(16.0).r,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: PrimaryText(
              text: 'Hide answers on quiz',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            tileColor: AppColors.unselectedItemBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
              side: BorderSide(color: Colors.transparent),
            ),
            trailing: BlocBuilder<ConfigurationCubit, BaseState>(
              builder: (context, state) {
                print('state: $state');
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                }

                if (state is SuccessState) {
                  final data = state.data as UserSettingsModel;
                  bool isQuizHidden = data.quizHidden ?? false;

                  return Switch(
                    value: isQuizHidden,
                    onChanged: (bool value) {
                      configurationCubit.changeQuizVisibility();
                      configurationProvider.toggleAnswerVisibility(value);
                    },
                    activeColor: AppColors.background,
                    activeTrackColor: AppColors.toggleBackground,
                    inactiveThumbColor: AppColors.toggleBackground,
                    inactiveTrackColor: AppColors.toggleOffBackground,
                    trackOutlineWidth: WidgetStateProperty.all(0.1),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}

/*

class ConfigurationBody extends StatelessWidget {
  const ConfigurationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final configurationProvider = context.watch<ConfigurationProvider>();
    final configurationCubit = context.read<ConfigurationCubit>();



    return Padding(
      padding: const EdgeInsets.all(16.0).r,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: PrimaryText(
              text: 'Hide answers on quiz',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            tileColor: AppColors.unselectedItemBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
              side: BorderSide(color: Colors.transparent),
            ),
            trailing: BlocBuilder<ConfigurationCubit, BaseState>(
              builder: (context, state) {
                print('state: $state');
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                }

                if (state is SuccessState) {
                  final data = state.data as UserSettingsModel;
                  bool isQuizHidden = data.quizHidden ?? false;

                  return Switch(
                    value: isQuizHidden,
                    onChanged: (bool value) {
                      configurationCubit.changeQuizVisibility();
                      configurationProvider.toggleAnswerVisibility(value);
                    },
                    activeColor: AppColors.background,
                    activeTrackColor: AppColors.toggleBackground,
                    inactiveThumbColor: AppColors.toggleBackground,
                    inactiveTrackColor: AppColors.toggleOffBackground,
                    trackOutlineWidth: WidgetStateProperty.all(0.1),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        },
      ),
    );
  }
}

 */
