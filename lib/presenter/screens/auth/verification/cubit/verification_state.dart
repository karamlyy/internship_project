import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class VerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationSuccess extends VerificationState {
  final ResponseModel responseModel;

  VerificationSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class VerificationFailure extends VerificationState {
  final ErrorMessage errorMessage;

  VerificationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}