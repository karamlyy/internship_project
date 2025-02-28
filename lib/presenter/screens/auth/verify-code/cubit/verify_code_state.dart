import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class VerifyCodeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final ResponseModel responseModel;

  VerifyCodeSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class VerifyCodeFailure extends VerifyCodeState {
  final ErrorMessage errorMessage;

  VerifyCodeFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}