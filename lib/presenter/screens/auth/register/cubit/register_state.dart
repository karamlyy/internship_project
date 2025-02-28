import 'package:equatable/equatable.dart';
import 'package:language_learning/data/model/auth/register_model.dart';
import 'package:language_learning/data/exception/error.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel registerModel;

  RegisterSuccess({required this.registerModel});

  @override
  List<Object?> get props => [registerModel];
}

class RegisterFailure extends RegisterState {
  final ErrorMessage errorMessage;

  RegisterFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}