import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_builder.dart';
import 'package:language_learning/presenter/screens/auth/login/cubit/login_cubit.dart';
import 'package:language_learning/presenter/screens/auth/login/provider/login_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/l10n/l10n.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    final loginCubit = context.read<LoginCubit>();
    return GenericBuilder<LoginCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryButton(
              title: L10n.signIn,
              isActive: loginProvider.isFormValid,
              onTap: () async {
                loginCubit.login(context, loginProvider.loginInput);
              },
              hasBorder: false,
            ),
            12.verticalSpace,
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.inputBorder, thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: AppColors.primaryText.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.inputBorder, thickness: 1)),
              ],
            ),

            12.verticalSpace,
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.inputBorder, width: 1),
                  borderRadius: BorderRadius.circular(12).r,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/google.svg',
                      height: 24.h,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                loginCubit.signInWithGoogle(context);

              },
            ),
          ],
        );
      },
    );
  }
}
