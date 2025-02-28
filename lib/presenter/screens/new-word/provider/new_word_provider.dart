import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/word/new_word_endpoint.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/utils/extensions/validation.dart';

class NewWordProvider extends ChangeNotifier {
  String _word = '';
  String _translation = '';
  bool _isLearningNow = false;

  String? _wordError;
  String? _translationError;

  bool get isLearningNow => _isLearningNow;

  String get word => _word;

  String get translation => _translation;

  String? get wordError => _wordError;

  String? get translationError => _translationError;


  LanguagePairModel? _selectedLanguagePair;

  LanguagePairModel? get selectedLanguagePair => _selectedLanguagePair;

  void setSelectedLanguagePair(LanguagePairModel languagePair) {
    _selectedLanguagePair = languagePair;
    notifyListeners();
  }


  NewWordInput get newWordInput => NewWordInput(
      source: _word, translation: _translation, isLearningNow: _isLearningNow);

  LanguagePairModel? getSelectedLanguagePair(List<LanguagePairModel> languagePairs) {
    try {
      return _selectedLanguagePair ?? languagePairs.firstWhere((pair) => pair.isSelected);
    } catch (e) {
      return null;
    }
  }

  void updateWord(String word) {
    _word = word;
    if (word.wordAdded()) {
      _wordError = null;
    } else {
      _wordError = 'written word is too short to add';
    }
    notifyListeners();
  }

  void updateTranslation(String translation) {
    _translation = translation;
    if (translation.wordAdded()) {
      _translationError = null;
    } else {
      _translationError = 'written word is too short';
    }
    notifyListeners();
  }

  void addLearning(bool value) {
    _isLearningNow = value;
    notifyListeners();
  }

  void resetFields() {
    _word = '';
    _translation = '';
    _isLearningNow = false;
    notifyListeners();
  }

  bool isWordFormValid() {
    return word.wordAdded() && translation.wordAdded();
  }
}
