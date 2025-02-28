import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class ResetPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {
  final ResponseModel responseModel;

  ResetPasswordSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class ResetPasswordFailure extends ResetPasswordState {
  final ErrorMessage errorMessage;

  ResetPasswordFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}