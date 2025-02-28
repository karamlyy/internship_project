import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_cubit.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_state.dart';
import 'package:language_learning/presenter/screens/auth/verification/provider/verification_provider.dart';
import 'package:language_learning/presenter/screens/auth/verification/view/verification_info.dart';
import 'package:language_learning/presenter/widgets/heading_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:pinput/pinput.dart';

class VerificationForm extends StatelessWidget {
  const VerificationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationProvider = context.watch<VerificationProvider>();
    final verificationCubit = context.read<VerificationCubit>();
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        if (state is VerificationLoading) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: EdgeInsets.all(16.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadingText(
                headingText: 'Verify your e-mail address',
                secondaryText: 'We’ve sent an activation code to your email.',
              ),

              42.verticalSpace,
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                length: 4,
                onChanged: verificationProvider.updateVerificationCode,
                onCompleted: (value) {
                  verificationCubit.confirmEmail(
                    verificationProvider.verificationInput,
                  );
                },
                defaultPinTheme: PinTheme(
                  width: (double.infinity / 4),
                  height: 70.h,
                  textStyle: const TextStyle(
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
                  width: (double.infinity / 4),
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
              30.verticalSpace,
              //VerificationInfo(),
            ],
          ),
        );
      },
    );
  }
}
