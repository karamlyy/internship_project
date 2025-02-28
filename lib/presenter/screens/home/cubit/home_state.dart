import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String message;

  HomeSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeFailure extends HomeState {
  final ErrorMessage errorMessage;

  HomeFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
