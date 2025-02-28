import 'package:flutter/material.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';

class LearningVocabularyProvider extends ChangeNotifier {
  bool _isAdded = false;

  bool get isAdded => _isAdded;

  void changeWordStatus(bool value) {
    _isAdded = value;
    notifyListeners();
  }

  LanguagePairModel? _selectedLanguagePair;


  LanguagePairModel? get selectedLanguagePair => _selectedLanguagePair;



  void setSelectedLanguagePair(LanguagePairModel languagePair) {
    _selectedLanguagePair = languagePair;
    notifyListeners();
  }

  LanguagePairModel? getSelectedLanguagePair(List<LanguagePairModel> languagePairs) {
    try {
      return _selectedLanguagePair ?? languagePairs.firstWhere((pair) => pair.isSelected);
    } catch (e) {
      return null;
    }
  }
}
