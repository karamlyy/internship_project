
import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class CreateLanguagePairState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateLanguageInitial extends CreateLanguagePairState {}

class CreateLanguageLoading extends CreateLanguagePairState {}

class CreateLanguageSuccess extends CreateLanguagePairState {
  final ResponseModel responseModel;

  CreateLanguageSuccess({required this.responseModel});

  @override
  List<Object?> get props => [responseModel];
}

class CreateLanguageFailure extends CreateLanguagePairState {
  final ErrorMessage errorMessage;

  CreateLanguageFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}