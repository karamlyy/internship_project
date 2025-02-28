import 'dart:async';

import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/login_endpoint.dart';
import 'package:language_learning/utils/extensions/validation.dart';

class LoginProvider extends ChangeNotifier {
  Timer? _debounce;

  String _email = '';
  String _password = '';
  bool _isBottomSheetOpen = false;

  bool get isBottomSheetOpen => _isBottomSheetOpen;

  void setBottomSheetState(bool isOpen) {
    _isBottomSheetOpen = isOpen;
    notifyListeners();
  }

  String? _emailError;
  String? _passwordError;

  bool _isPasswordVisible = false;

  String get email => _email;

  String get password => _password;

  String? get emailError => _emailError;

  String? get passwordError => _passwordError;

  bool get isPasswordVisible => _isPasswordVisible;

  LoginInput get loginInput => LoginInput(email: _email, password: _password);

  void changePasswordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  void updateEmail(String email) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      _email = email;
      if (email.isValidEmail()) {
        _emailError = null;
      } else {
        _emailError = 'Email format is invalid';
      }
      notifyListeners();
    });
  }

  void updatePassword(String password) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      _password = password;
      if (_password.isValidPassword()) {
        _passwordError = null;
      } else {
        _passwordError = 'Password is too short';
      }
      notifyListeners();
    });
  }

  bool get isFormValid {
    final isValidField = _emailError == null && _passwordError == null;
    final isValidValue = _email.isNotEmpty && _password.isNotEmpty;
    return isValidField && isValidValue;
  }
}
