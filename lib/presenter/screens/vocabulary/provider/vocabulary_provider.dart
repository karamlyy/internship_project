import 'dart:async';
import 'package:flutter/material.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';

class VocabularyProvider extends ChangeNotifier {
  String _prompt = '';

  String get prompt => _prompt;

  List<WordPairModel> _selectedWords = [];

  List<WordPairModel> get selectedWords => _selectedWords;

  void toggleWordSelection(WordPairModel word) {
    if (_selectedWords.contains(word)) {
      _selectedWords.remove(word);
    } else {
      _selectedWords.add(word);
    }
    notifyListeners();
  }

  void clearSelections() {
    _selectedWords.clear();
    notifyListeners();
  }

  void selectAllWords(List<WordPairModel> words) {
    _selectedWords = List.from(words);
    print('_selectedWords: $_selectedWords');
    notifyListeners();
  }

  void clearSelectedWords() {
    _selectedWords.clear();
    notifyListeners();
  }

  void updateUserPrompt(String prompt) {
    _prompt = prompt;
    notifyListeners();
  }

  bool _isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  int _selectedSegmentIndex = 0;

  int get selectedSegmentIndex => _selectedSegmentIndex;

  void updateSegmentIndex(int index) {
    _selectedSegmentIndex = index;
    notifyListeners();
  }

  bool get isSearchActive => _isSearchActive;

  void toggleSearch() {
    _isSearchActive = !_isSearchActive;
    if (!_isSearchActive) {
      searchController.clear();
    }
    notifyListeners();
  }

  bool _isAdded = false;

  bool get isAdded => _isAdded;

  void changeWordStatus(List<WordPairModel> words, int index) {
    _isAdded = !_isAdded;
    words[index].isLearningNow = !words[index].isLearningNow;

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