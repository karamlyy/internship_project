import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/register_endpoint.dart';
import 'package:language_learning/utils/extensions/validation.dart';

class RegisterProvider extends ChangeNotifier {
  bool _isWeeklySummaryEnabled = false;
  bool _isTermsAndConditionsAccepted = false;
  bool _isPasswordVisible = false;

  String _email = '';
  String _password = '';
  String _userId = '';

  String? _emailError;
  String? _passwordError;

  bool get isWeeklySummaryEnabled => _isWeeklySummaryEnabled;

  bool get isTermsAndConditionsAccepted => _isTermsAndConditionsAccepted;

  bool get isPasswordVisible => _isPasswordVisible;

  String get email => _email;

  String get password => _password;

  String get userId => _userId;

  String? get emailError => _emailError;

  String? get passwordError => _passwordError;

  bool _isBottomSheetOpen = false;
  bool get isBottomSheetOpen => _isBottomSheetOpen;

  void setBottomSheetState (bool isOpen ) {
    _isBottomSheetOpen = isOpen;
    notifyListeners();
  }

  RegisterInput get registerInput => RegisterInput(email: _email, password: _password);


  void toggleWeeklySummary(bool value) {
    _isWeeklySummaryEnabled = value;
    notifyListeners();
  }

  void acceptTermsAndConditions(bool value) {
    _isTermsAndConditionsAccepted = value;
    notifyListeners();
  }

  void changePasswordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    if (email.isValidEmail()) {
      _emailError = null;
    } else {
      _emailError = 'Email format is invalid';
    }
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    if (password.isValidPassword()) {
      _passwordError = null;
    } else {
      _passwordError = 'Password length must be greater than 8';
    }
    notifyListeners();
  }

  bool get isFormValid {
    final isValidField = _emailError == null && _passwordError == null && _isTermsAndConditionsAccepted;
    final isValidValue = _email.isNotEmpty && _password.isNotEmpty;
    return isValidField && isValidValue;
  }
}
