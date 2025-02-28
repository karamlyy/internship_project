import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/change-password/cubit/change_password_cubit.dart';
import 'package:language_learning/presenter/screens/change-password/provider/change_password_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final changePasswordProvider = context.watch<ChangePasswordProvider>();
    final changePasswordCubit = context.read<ChangePasswordCubit>();

    return GenericBuilder<ChangePasswordCubit, BaseState>(
      builder: (context, state) {

        return PrimaryButton(
          title: 'Confirm',
          hasBorder: false,
          isActive: changePasswordProvider.isFormValid(),
          onTap: () async {
            changePasswordCubit
                .changePassword(changePasswordProvider.changePasswordInput);
          },
        );
      },
    );
  }
}
