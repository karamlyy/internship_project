import 'package:flutter/material.dart';

class ConfigurationProvider extends ChangeNotifier {
  bool _isAnswersHidden = false;
  bool _isNotificationsEnabled = false;
  bool _isListenable = false;

  bool get isAnswersHidden => _isAnswersHidden;
  bool get isNotificationsEnabled => _isNotificationsEnabled;
  bool get isListenable => _isListenable;

  void toggleAnswerVisibility(bool value) {
    _isAnswersHidden = value;
    notifyListeners();
  }

  void toggleNotificationStatus(bool value) {
    _isNotificationsEnabled = value;
    notifyListeners();
  }

  void toggleListenable(bool value) {
    _isListenable = value;
    notifyListeners();
  }


}
