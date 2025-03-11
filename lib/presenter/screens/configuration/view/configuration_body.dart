import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/settings/user_settings_model.dart';
import 'package:language_learning/presenter/screens/configuration/cubit/configuration_cubit.dart';
import 'package:language_learning/presenter/screens/configuration/provider/configuration_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import '../../../../generic/base_state.dart';

class ConfigurationBody extends StatelessWidget {
  const ConfigurationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final configurationProvider = context.watch<ConfigurationProvider>();
    final configurationCubit = context.read<ConfigurationCubit>();

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          _buildSwitchTile(
            context,
            title: 'Hide answers on quiz',
            stateSelector: (settings) => settings.quizHidden ?? false,
            onChanged: (value) {
              configurationCubit.changeQuizVisibility();
              configurationProvider.toggleAnswerVisibility(value);
            },
          ),
          6.verticalSpace,
          _buildSwitchTile(
            context,
            title: 'Change Notification',
            stateSelector: (settings) => settings.notificationDisabled ?? false,
            onChanged: (value) {
              configurationCubit.changeNotificationStatus();
              configurationProvider.toggleNotificationStatus(value);
            },
          ),
          6.verticalSpace,
          _buildSwitchTile(
            context,
            title: 'Change Quiz Voice',
            stateSelector: (settings) => settings.quizListenable ?? false,
            onChanged: (value) {
              configurationCubit.changeQuizListenable();
              configurationProvider.toggleListenable(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
      BuildContext context, {
        required String title,
        required bool Function(UserSettingsModel) stateSelector,
        required ValueChanged<bool> onChanged,
      }) {
    return ListTile(
      title: PrimaryText(
        text: title,
        color: AppColors.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      tileColor: AppColors.unselectedItemBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
        side: const BorderSide(color: Colors.transparent),
      ),
      trailing: BlocBuilder<ConfigurationCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

          if (state is SuccessState) {
            final data = state.data as UserSettingsModel;
            bool value = stateSelector(data);

            return Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.background,
              activeTrackColor: AppColors.toggleBackground,
              inactiveThumbColor: AppColors.toggleBackground,
              inactiveTrackColor: AppColors.toggleOffBackground,
              trackOutlineWidth: WidgetStateProperty.all(0.1),
            );
          }

          return const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
      ),
    );
  }
}