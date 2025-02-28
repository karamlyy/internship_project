import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/presenter/screens/auth/verification/provider/verification_provider.dart';
import 'package:language_learning/presenter/widgets/primary_footer.dart';

class VerificationInfo extends StatelessWidget {
  const VerificationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VerificationProvider>(
      builder: (context, provider, child) {
        return PrimaryFooter(
          onTap: () {},
          //mainText: ' ${provider.remainingSeconds}s ',
          secondaryText: provider.remainingSeconds > 0 ? 'Resend Code in ${provider.remainingSeconds}s' : 'Send Code Again',
        );
      },
    );
  }
}
