import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/verify_code_endpoint.dart';


class VerifyCodeProvider extends ChangeNotifier {
  String _code = '';
  String _userId = '';
  String _codeExpiry = '';
  String? _error;

  String get code => _code;

  String get userId => _userId;

  String get codeExpiry => _codeExpiry;

  String? get error => _error;

  void updateVerifyCodeCode(String code) {
    _code = code;

    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setCodeExpiry(String codeExpiry) {
    _codeExpiry = codeExpiry;
    notifyListeners();
  }



  VerifyCodeInput get verifyCodeInput => VerifyCodeInput(userId: _userId, code: _code);
}
