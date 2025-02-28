import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/auth/register_model.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_cubit.dart';
import 'package:language_learning/presenter/screens/auth/verification/cubit/verification_state.dart';
import 'package:language_learning/presenter/screens/auth/verification/provider/verification_provider.dart';
import 'package:language_learning/presenter/screens/auth/verification/view/verification_body.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatelessWidget {
  final RegisterModel registerModel;

  const VerificationPage({
    super.key,
    required this.registerModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerificationCubit(),
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => VerificationProvider()
            ..setUserId(registerModel.userId ?? '')
            ..setCodeExpiry(registerModel.codeExpiry ?? ''),
          child: BlocListener<VerificationCubit, VerificationState>(
            listener: (context, state) {
              if (state is VerificationSuccess) {
                print(
                  'Successful verification',
                );
              } else if (state is VerificationFailure) {
                PrimaryBottomSheet.show(
                  context,
                  text: 'Wrong code, please try again',
                );
              }
            },
            child: VerificationBody(
              userId: registerModel.userId ?? '',
              codeExpiry: registerModel.codeExpiry ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
