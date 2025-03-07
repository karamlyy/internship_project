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

  final List<WordPairModel> _selectedWordsId = [];

  List<WordPairModel> get selectedWords => _selectedWordsId;

  void toggleWordSelection(WordPairModel word) {
    if (_selectedWordsId.where((args) => args.id == word.id).isNotEmpty) {
      _selectedWordsId.remove(word);
    } else {
      _selectedWordsId.add(word);
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
