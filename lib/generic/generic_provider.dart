import 'package:flutter/material.dart';

class GenericProvider extends ChangeNotifier {
  bool _isBottomSheetOpen = false;

  bool get isBottomSheetOpen => _isBottomSheetOpen;

  void setBottomSheetState(bool isOpen) {
    _isBottomSheetOpen = isOpen;
    notifyListeners();
  }
}
