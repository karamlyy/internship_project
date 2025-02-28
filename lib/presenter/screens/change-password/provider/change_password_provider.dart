import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/change_password_endpoint.dart';
import 'package:language_learning/utils/extensions/validation.dart';

class ChangePasswordProvider extends ChangeNotifier {
  String _password = '';
  String _newPassword = '';
  String _confirmPassword = '';

  String? _passwordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String get password => _password;

  String get newPassword => _newPassword;

  String get confirmPassword => _confirmPassword;

  String? get passwordError => _passwordError;

  String? get newPasswordError => _newPasswordError;

  String? get confirmPasswordError => _confirmPasswordError;

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isNewPasswordVisible => _isNewPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  ChangePasswordInput get changePasswordInput => ChangePasswordInput(
      currentPassword: _password, newPassword: _confirmPassword);

  void changePasswordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  void changeNewPasswordVisibility(bool value) {
    _isNewPasswordVisible = value;
    notifyListeners();
  }

  void changeConfirmPasswordVisibility(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    if (password.isValidPassword()) {
      _passwordError = null;
    } else {
      _passwordError = 'Password is too short';
    }
    notifyListeners();
  }

  void updateNewPassword(String newPassword) {
    _newPassword = newPassword;
    if (newPassword.isValidPassword()) {
      _newPasswordError = null;
    } else {
      _newPasswordError = 'Password is too short';
    }
    notifyListeners();
  }

  void updateConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    if (confirmPassword.isValidPassword()) {
      _confirmPasswordError = null;
    } else {
      _confirmPasswordError = 'Password is too short';
    }
    notifyListeners();
  }

  bool isPasswordValid() {
    return _password.isValidPassword();
  }

  bool isNewPasswordValid() {
    return _newPassword.isValidPassword();
  }

  bool isPasswordMatch() {
    return _confirmPassword == _newPassword;
  }

  bool isFormValid() {
    return isPasswordValid() && isNewPasswordValid() && isPasswordMatch();
  }
}
