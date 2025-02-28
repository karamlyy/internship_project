import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/auth/forgot_password_model.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/cubit/verify_code_cubit.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/cubit/verify_code_state.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/provider/verify_code_provider.dart';
import 'package:language_learning/presenter/screens/auth/verify-code/view/verify_code_body.dart';
import 'package:language_learning/presenter/widgets/primary_bottom_sheet.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatelessWidget {
  final ForgotPasswordModel forgotPasswordModel;

  const VerifyCodePage({
    super.key,
    required this.forgotPasswordModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCodeCubit(forgotPasswordModel),
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => VerifyCodeProvider()
            ..setUserId(forgotPasswordModel.userId ?? '')
            ..setCodeExpiry(forgotPasswordModel.codeExpiry ?? ''),
          child: BlocListener<VerifyCodeCubit, VerifyCodeState>(
            listener: (context, state) {
              if (state is VerifyCodeSuccess) {
                print("Successful VerifyCode");
              } else if (state is VerifyCodeFailure) {
                PrimaryBottomSheet.show(context,
                    text: state.errorMessage.message);
              }
            },
            child: VerifyCodeBody(
              userId: forgotPasswordModel.userId ?? '',
              codeExpiry: forgotPasswordModel.codeExpiry ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
