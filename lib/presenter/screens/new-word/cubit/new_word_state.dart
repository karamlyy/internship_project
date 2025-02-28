
import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/base/response_model.dart';

class NewWordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewWordInitial extends NewWordState {}

class NewWordLoading extends NewWordState {}

class NewWordSuccess extends NewWordState {
  final ResponseModel data;

  NewWordSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class NewWordFailure extends NewWordState {
  final ErrorMessage errorMessage;

  NewWordFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}