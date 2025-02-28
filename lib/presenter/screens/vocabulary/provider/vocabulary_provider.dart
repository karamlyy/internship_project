import 'dart:async';
import 'package:flutter/material.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';

class VocabularyProvider extends ChangeNotifier {
  bool _isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;


  bool get isSearchActive => _isSearchActive;

  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    if (!_isSearchActive) {
      searchController.clear();
    }
    notifyListeners();
  }

  bool _isAdded = false;
  bool _isMastered = false;
  bool _isAddedToLearning = false;

  bool get isAdded => _isAdded;
  bool get isMastered => _isMastered;
  bool get isAddedToLearning => _isAddedToLearning;



  void changeWordStatus(bool value) {
    _isAdded = value;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    notifyListeners();
  }

  void onSearchChanged(String query, Function(String) onSearch) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      onSearch(query);
    });
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
