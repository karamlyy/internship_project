import 'package:flutter/material.dart';
import 'package:language_learning/data/model/home/language_pair_model.dart';
import 'package:language_learning/data/model/home/word_pair_model.dart';

class MasteredVocabularyProvider extends ChangeNotifier {
  bool _isAdded = false;

  bool get isAdded => _isAdded;

  void changeWordStatus(bool value) {
    _isAdded = value;
    notifyListeners();
  }

  LanguagePairModel? _selectedLanguagePair;


  LanguagePairModel? get selectedLanguagePair => _selectedLanguagePair;

  List<WordPairModel> _selectedWords = [];

  List<WordPairModel> get selectedWords => _selectedWords;

  void selectAllWords(List<WordPairModel> words) {
    _selectedWords = List.from(words);
    notifyListeners();
  }

  void deselectAllWords() {
    _selectedWords.clear();
    notifyListeners();
  }


  void toggleWordSelection(WordPairModel word) {
    if (_selectedWords.where((args) => args.id == word.id).isNotEmpty) {
      _selectedWords.remove(word);
    } else {
      _selectedWords.add(word);
    }
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
