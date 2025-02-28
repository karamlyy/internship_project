import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/auth/login_model.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});

  @override
  List<Object?> get props => [loginModel];
}

class LoginFailure extends LoginState {
  final ErrorMessage errorMessage;

  LoginFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
