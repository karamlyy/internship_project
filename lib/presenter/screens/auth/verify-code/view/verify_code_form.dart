import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/cubit/verify_code_cubit.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/cubit/verify_code_state.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/provider/verify_code_provider.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeForm extends StatelessWidget {
  const VerifyCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final verifyCodeProvider = context.watch<VerifyCodeProvider>();
    final verifyCodeCubit = context.read<VerifyCodeCubit>();
    return BlocBuilder<VerifyCodeCubit, VerifyCodeState>(
      builder: (context, state) {
        if (state is VerifyCodeLoading) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeadingText(
                headingText: 'Please check your email',
                secondaryText: 'We’ve sent an activation code to your email',
              ),
              42.verticalSpace,
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                length: 4,
                onChanged: verifyCodeProvider.updateVerifyCodeCode,
                onCompleted: (value) {
                  verifyCodeCubit.verifyCode(verifyCodeProvider.verifyCodeInput);
                },
                defaultPinTheme: PinTheme(
                  width: (double.infinity / 4),
                  height: 70.h,
                  textStyle: TextStyle(
                    fontSize: 28,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.inputBorder),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: (double.infinity / 5),
                  height: 72.h,
                  textStyle: const TextStyle(
                    fontSize: 28,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryText),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
