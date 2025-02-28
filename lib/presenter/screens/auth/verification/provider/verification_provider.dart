import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/verification_endpoint.dart';
import 'dart:async';
import 'package:intl/intl.dart';
class VerificationProvider extends ChangeNotifier {
  String _code = '';
  String _userId = '';
  String _codeExpiry = '';
  String? _error;
  int _remainingSeconds = 0;
  Timer? _countdownTimer;

  String get code => _code;
  String get userId => _userId;
  String get codeExpiry => _codeExpiry;
  String? get error => _error;
  int get remainingSeconds => _remainingSeconds;

  void updateVerificationCode(String code) {
    _code = code;
    notifyListeners();
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setCodeExpiry(String codeExpiry) {
    _codeExpiry = codeExpiry;
    _startCountdown();
    notifyListeners();
  }

  void _startCountdown() {
    if (_countdownTimer != null) {
      _countdownTimer!.cancel();
    }

    DateTime now = DateTime.now();
    DateTime expiryTime = _parseExpiryTime(_codeExpiry);

    _remainingSeconds = expiryTime.difference(now).inSeconds;

    if (_remainingSeconds > 0) {
      _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        _remainingSeconds--;

        if (_remainingSeconds <= 0) {
          timer.cancel();
        }

        notifyListeners();
      });
    }
  }

  DateTime _parseExpiryTime(String expiryTime) {
    DateTime now = DateTime.now();
    List<String> parts = expiryTime.split(":");

    if (parts.length == 3) { // HH:MM:SS format
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      int second = int.parse(parts[2]);

      return DateTime(now.year, now.month, now.day, hour, minute, second);
    } else {
      throw FormatException("Invalid expiry time format");
    }
  }

  VerificationInput get verificationInput =>
      VerificationInput(userId: _userId, code: _code);
}
