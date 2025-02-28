import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/generic/generic_listener.dart';
import 'package:language_learning/presenter/screens/auth/register/cubit/register_cubit.dart';
import 'package:language_learning/presenter/screens/auth/register/provider/register_provider.dart';
import 'package:language_learning/presenter/screens/auth/register/view/register_body.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
          child: GenericListener<RegisterCubit, BaseState>(
            listener: (context, errorMessage) {},
            child: RegisterBody(),
          ),
        ),
      ),
    );
  }
}
