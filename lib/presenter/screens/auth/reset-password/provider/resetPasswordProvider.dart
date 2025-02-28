import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/reset_password_endpoint.dart';
import 'package:language_learning/utils/extensions/validation.dart';

class ResetPasswordProvider extends ChangeNotifier {
  String _password = '';
  String _confirmPassword = '';
  String _userId = '';

  String? _passwordError;
  String? _confirmPasswordError;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String get password => _password;

  String get confirmPassword => _confirmPassword;

  String get userId => _userId;

  String? get passwordError => _passwordError;

  String? get confirmPasswordError => _confirmPasswordError;

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  ResetPasswordInput get resetPasswordInput =>
      ResetPasswordInput(userId: _userId, newPassword: _confirmPassword);

  void changePasswordVisibility(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  void changeConfirmPasswordVisibility(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
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

  bool isConfirmPasswordValid() {
    return _confirmPassword.isValidPassword();
  }

  bool isPasswordMatch() {
    return _password == _confirmPassword;
  }

  bool isFormValid() {
    return isPasswordValid() && isConfirmPasswordValid() && isPasswordMatch();
  }
}
