import 'package:flutter/material.dart';

class ConfigurationProvider extends ChangeNotifier {
  bool _isAnswersHidden = false;
  bool _isNotificationsEnabled = false;

  bool get isAnswersHidden => _isAnswersHidden;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  void toggleAnswerVisibility(bool value) {
    _isAnswersHidden = value;
    notifyListeners();
  }

  void toggleNotificationStatus(bool value) {
    _isNotificationsEnabled = value;
    notifyListeners();
  }
}
