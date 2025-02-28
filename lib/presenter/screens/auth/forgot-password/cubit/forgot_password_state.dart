
import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/auth/forgot_password_model.dart';

class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordModel forgotPasswordModel;

  ForgotPasswordSuccess({required this.forgotPasswordModel});

  @override
  List<Object?> get props => [forgotPasswordModel];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final ErrorMessage errorMessage;

  ForgotPasswordFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
