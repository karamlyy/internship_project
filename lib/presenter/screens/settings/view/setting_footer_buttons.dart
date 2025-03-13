import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/settings/cubit/settings_cubit.dart';
import 'package:language_learning/presenter/screens/settings/settings_options.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/settings_card.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';

class SettingsFooterButtons extends StatelessWidget {
  const SettingsFooterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    return GenericBuilder<SettingsCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            SettingsCard(
              title: L10n.deleteAccount,
              trailingIcon: Icon(SettingsOption.deleteAccount.icon),
              iconColor: AppColors.hintText,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: PrimaryText(
                        text: L10n.areYouSureToDeleteAccount,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),

                      actions: [
                        PrimaryButton(
                          title: L10n.yes,
                          hasBorder: false,
                          isActive: true,
                          onTap: () {
                            settingsCubit.deleteUser();
                          },
                        ),
                        10.verticalSpace,
                        PrimaryButton(
                          title: L10n.no,
                          hasBorder: true,
                          isActive: true,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                      elevation: 24,
                    );
                  },
                );
              },
            ),
            SettingsCard(
              title: L10n.logoutAccount,
              trailingIcon: Icon(SettingsOption.logout.icon),
              iconColor: AppColors.error,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: PrimaryText(
                        text: L10n.logoutAccount,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Inter',
                      ),

                      actions: [
                        PrimaryButton(
                          title: L10n.yes,
                          hasBorder: false,
                          isActive: true,
                          onTap: () {
                            settingsCubit.logoutUser();
                          },
                        ),
                        10.verticalSpace,
                        PrimaryButton(
                          title: L10n.no,
                          hasBorder: true,
                          isActive: true,
                          onTap: () {
                            Navigator.of(context).pop();
                          },

                        ),
                      ],
                      elevation: 24,
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
