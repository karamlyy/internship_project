import 'package:flutter/material.dart';

class AppbarProvider extends ChangeNotifier {
  bool _isSearching = false;

  bool get isSearching => _isSearching;

  void changeSearchBarStatus(bool value) {
    _isSearching = value;
    notifyListeners();
  }
}
