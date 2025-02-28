import 'package:flutter/material.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';

class HomeProvider extends ChangeNotifier {
  int? _selectedCategoryId;

  LanguagePairModel? _selectedLanguagePair;

  int? get selectedCategoryId => _selectedCategoryId;

  LanguagePairModel? get selectedLanguagePair => _selectedLanguagePair;

  void selectCategory(int id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

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
