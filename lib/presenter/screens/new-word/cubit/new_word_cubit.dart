import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/data/endpoint/word/new_word_endpoint.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/data/repository/file_repository.dart';
import 'package:language_learning/data/repository/home_repository.dart';
import 'package:language_learning/data/repository/word_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/downloader-service/downloader_service.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:rxdart/rxdart.dart';

class NewWordCubit extends Cubit<BaseState> {
  NewWordCubit() : super(InitialState()) {
    getAllLanguagePairs();
  }

  final _wordRepository = getIt<WordRepository>();
  final _homeRepository = getIt<HomeRepository>();
  final _fileRepository = getIt<FileRepository>();

  final _downloadService = DownloaderService();

  final _languagePairController = BehaviorSubject<List<LanguagePairModel>>();
  final _fileController = BehaviorSubject<void>();

  Stream<List<LanguagePairModel>> get languagePairController =>
      _languagePairController.stream;

  Stream<void> get fileController => _fileController.stream;

  Future<void> getAllLanguagePairs() async {
    final result = await _homeRepository.getAllLanguagePairs();
    result.fold(
      (error) {
        emit(FailureState(errorMessage: error.error));
      },
      (data) {
        _languagePairController.add(data);
      },
    );
  }

  Future<void> uploadFile(BuildContext context, File file) async {
    emit(LoadingState());

    final result = await _fileRepository.uploadTemplate(file);
    result.fold(
      (error) {
        emit(FailureState(errorMessage: error.error));
      },
      (data) {
        _fileController.add(data);
        Navigation.pushReplacementNamed(Routes.home);
        context.read<HomeCubit>()
          ..getCardCounts()
          ..getLastWords()
          ..getAllLanguagePairs();
      },
    );
  }

  void downloadTemplate() async {
    emit(LoadingState());
    final result = await _fileRepository.downloadTemplate();
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) async {
        await _downloadService.convertBase64ToExcel(
            base64String: data.fileContent ?? '');
        Navigation.push(Routes.home);
      },
    );
  }

  Future<void> addNewWord(NewWordInput input) async {
    emit(LoadingState());
    final result = await _wordRepository.addNewWord(input);
    result.fold(
      (error) => emit(
        FailureState(errorMessage: error.error),
      ),
      (data) {
        Navigation.pushReplacementNamed(Routes.newWord);
      },
    );
  }
}
