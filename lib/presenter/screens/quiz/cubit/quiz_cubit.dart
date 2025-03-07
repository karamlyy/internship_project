import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/quiz/create_quiz_session_endpoint.dart';
import 'package:language_learning/data/repository/quiz_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/quiz/provider/quiz_provider.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

class QuizCubit extends Cubit<BaseState> {
  QuizCubit() : super(InitialState());

  final _quizRepository = getIt<QuizRepository>();
  final List<int> _askedQuestionIds = [];

  Future<void> getQuizQuestion() async {
    emit(LoadingState());
    final result = await _quizRepository.getQuizQuestion(
      _askedQuestionIds.isEmpty ? [0] : _askedQuestionIds,
    );
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        _askedQuestionIds.add(data.id ?? 0);
        emit(SuccessState(data: data));
      },
    );
  }

  void getMasterQuizQuestion() async {
    emit(LoadingState());
    final result = await _quizRepository.getQuizQuestion(
      _askedQuestionIds.isEmpty ? [0] : _askedQuestionIds,
      isMastered: true,
    );
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        _askedQuestionIds.add(data.id ?? 0);
        emit(SuccessState(data: data));
      },
    );
  }

  Future<void> addToMaster(int id, QuizProvider quizProvider) async {
    final result = await _quizRepository.addToMaster(id, true);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        quizProvider.addToMaster(!quizProvider.isAddedToMaster);
      },
    );
  }

  void createQuizReport(int correctAnswerCount) async {
    final result = await _quizRepository.createQuizReport(correctAnswerCount);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        Navigation.pushNamedAndRemoveUntil(Routes.home);
      },
    );
  }

  Future<void> createQuizSession(CreateQuizSessionInput input) async {
    final result = await _quizRepository.quizSession(input);
    emit(LoadingState());
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        Navigation.pop();
      },
    );
  }

  List<int> get askedQuestionIds => _askedQuestionIds;
}
