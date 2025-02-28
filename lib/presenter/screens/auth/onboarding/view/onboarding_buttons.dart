import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/app/app_cubit.dart';
import 'package:language_learning/app/app_state.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = context.read<AppCubit>();
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                title: L10n.signIn,
                hasBorder: false,
                isActive: true,
                backgroundColor: AppColors.primary,
                onTap: () {
                  appCubit.passOnboarding();
                  Navigation.push(Routes.login);
                },
              ),
              14.verticalSpace,
              PrimaryButton(
                title: L10n.signUp,
                isActive: true,
                hasBorder: true,
                onTap: () {
                  appCubit.passOnboarding();
                  Navigation.push(Routes.register);
                },
              ),
              50.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
