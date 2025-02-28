import 'package:equatable/equatable.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/auth/login_model.dart';
import 'package:language_learning/data/model/home/user_vocabulary_model.dart';

class VocabularyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VocabularyInitial extends VocabularyState {}

class VocabularyLoading extends VocabularyState {}

class VocabularySuccess extends VocabularyState {
  final UserVocabularyModel userVocabularyModel;

  VocabularySuccess({required this.userVocabularyModel});

  @override
  List<Object?> get props => [userVocabularyModel];
}

class VocabularyFailure extends VocabularyState {
  final ErrorMessage errorMessage;

  VocabularyFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
