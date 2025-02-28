import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_cubit.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_state.dart';
import 'package:language_learning/presenter/screens/auth/verification/provider/verification_provider.dart';
import 'package:language_learning/presenter/widgets/primary_footer.dart';

class VerificationFooter extends StatelessWidget {
  const VerificationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationProvider = context.watch<VerificationProvider>();
    final verificationCubit = context.read<VerificationCubit>();
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        if (state is VerificationLoading) {
          return const CircularProgressIndicator();
        }
        return PrimaryFooter(
          onTap: () {
            verificationCubit.resendConfirmationEmail(verificationProvider.userId);
          },
          mainText: ' Resend',
          secondaryText: 'I didn’t receive a code. ',
        );
      },
    );
  }
}
