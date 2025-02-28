
import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class SetLanguageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetLanguageInitial extends SetLanguageState {}

class SetLanguageLoading extends SetLanguageState {}

class SetLanguageSuccess extends SetLanguageState {
  final ResponseModel responseModel;

  SetLanguageSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class SetLanguageFailure extends SetLanguageState {
  final ErrorMessage errorMessage;

  SetLanguageFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}