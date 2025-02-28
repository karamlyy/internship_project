import 'package:flutter/material.dart';

class ConfigurationProvider extends ChangeNotifier {
  bool _isAnswersHidden = false;

  bool get isAnswersHidden => _isAnswersHidden;

  void toggleAnswerVisibility(bool value) {
    _isAnswersHidden = value;
    notifyListeners();
  }


}
