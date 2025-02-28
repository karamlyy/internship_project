import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';

class BaseState<T> extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState<T> extends BaseState<T> {}

class LoadingState<T> extends BaseState<T> {}

class SuccessState<T> extends BaseState<T> {
  final T data;

  SuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FailureState<T> extends BaseState<T> {
  final ErrorMessage errorMessage;
  

  FailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
