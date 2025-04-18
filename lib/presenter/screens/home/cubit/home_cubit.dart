import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/model/home/card_model.dart';
import 'package:language_learning/data/model/home/user_vocabulary_model.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/settings_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeCubit extends Cubit<BaseState> {
  HomeCubit() : super(InitialState()) {
    getAllLanguagePairs();
    getLastWords();
    getCardCounts();
  }

  final _countController = BehaviorSubject<CardModel>();
  final _lastWordsController = BehaviorSubject<UserVocabularyModel>();



  Stream<CardModel> get countController => _countController.stream;

  Stream<UserVocabularyModel> get lastWordsController =>
      _lastWordsController.stream;

  final _homeRepository = getIt<HomeRepository>();
  final _settingsRepository = getIt<SettingsRepository>();

  Future<void> getAllLanguagePairs() async {
    emit(LoadingState());
    final result = await _homeRepository.getAllLanguagePairs();
    result.fold(
      (error) {
        emit(FailureState(errorMessage: error.error));
      },
      (data) {
        emit(SuccessState(data: data));
      },
    );
  }

  Future<void> setSelectedLanguagePair(int id) async {
    final result = await _homeRepository.setSelectedLanguagePair(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (_) {
        getAllLanguagePairs();
      },
    );
  }


  Future<void> swapLanguages(int id) async {
    emit(LoadingState());
    final result = await _settingsRepository.swapLanguages(id);
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) {
        getAllLanguagePairs();
      },
    );
  }

  Future<void> getCardCounts() async {
    final result = await _homeRepository.getCardCounts();
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        log("getCardCounts ${data.totalCount}");
        _countController.add(data);
      },
    );
  }

  Future<void> getLastWords() async {
    final result = await _homeRepository.getAllWords(1, 20);
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        _lastWordsController.add(data);
      },
    );
  }
}
