/*
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static PreferencesService? _instance;
  static SharedPreferences? _preferences;

  PreferencesService._internal();

  static Future<PreferencesService> get instance async {
    _instance ??= PreferencesService._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  final _authorizationPassed = "authorizationPassed";
  final _confirmationPassed = "confirmationPassed";
  final _setLanguagePassed = "setLanguagePassed";
  final _setTimingPassed = "setTimingPassed";
  final _accessToken = "accessToken";
  final _refreshToken = "refreshToken";
  final _userId = "userId";
  final _fullName = "fullname";
  final _onBoardingPassed = "onBoardingPassed";
  final _fcmToken = "fcmToken";

  setAuthorizationPassed(bool value) async => await _preferences?.setBool(_authorizationPassed, value);
  setConfirmationPassed(bool value) async => await _preferences?.setBool(_confirmationPassed, value);
  setLanguagePassed(bool value) async => await _preferences?.setBool(_setLanguagePassed, value);
  setTimingPassed(bool value) async => await _preferences?.setBool(_setTimingPassed, value);

  setAccessToken(String value) async => await _preferences?.setString(_accessToken, value);
  setRefreshToken(String value) async => await _preferences?.setString(_refreshToken, value);
  setFullName(String value) async => await _preferences?.setString(_fullName, value);
  setUserId(String value) async => await _preferences?.setString(_userId, value);
  setFcmToken(String value) async => await _preferences?.setString(_fcmToken, value);
  setOnBoardingPassed(bool value) async => await _preferences?.setBool(_onBoardingPassed, value);

  bool get wasAuthorizationPassed => _preferences?.getBool(_authorizationPassed) ?? false;
  bool get wasConfirmationPassed => _preferences?.getBool(_confirmationPassed) ?? false;
  bool get wasLanguagePassed => _preferences?.getBool(_setLanguagePassed) ?? false;
  bool get wasTimingPassed => _preferences?.getBool(_setTimingPassed) ?? false;
  String? get accessToken => _preferences?.getString(_accessToken);
  String? get fcmToken => _preferences?.getString(_fcmToken);
  String? get refreshToken => _preferences?.getString(_refreshToken);
  bool get wasOnBoardingPassed => _preferences?.getBool(_onBoardingPassed) ?? false;
  String? get userId => _preferences?.getString(_userId);
  String? get fullName => _preferences?.getString(_fullName);

  Future<bool?> clear() async => await _preferences?.clear();
}

 */


import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static PreferencesService? _instance;
  static SharedPreferences? _preferences;

  PreferencesService._internal();

  static Future<PreferencesService> get instance async {
    _instance ??= PreferencesService._internal();

    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  final _authorizationPassed = "authorizationPassed";
  final _confirmationPassed = "confirmationPassed";
  final _setLanguagePassed = "setLanguagePassed";
  final _setTimingPassed = "setTimingPassed";
  final _accessToken = "accessToken";
  final _refreshToken = "refreshToken";
  final _langTitle = "langTitle";
  final _appLanguage = "appLanguage";

  final _userId = "userId";
  final _fullName = "fullname";
  final _onBoardingPassed = "onBoardingPassed";
  final _fcmToken = "fcmToken";

  setAuthorizationPassed(bool value) async => await _preferences?.setBool(_authorizationPassed, value);
  setConfirmationPassed(bool value) async => await _preferences?.setBool(_confirmationPassed, value);
  setLanguagePassed(bool value) async => await _preferences?.setBool(_setLanguagePassed, value);
  setTimingPassed(bool value) async => await _preferences?.setBool(_setTimingPassed, value);
  setLanguageTitle(String value) async => await _preferences?.setString(_langTitle, value);
  setLanguage(String value) async => await _preferences?.setString(_appLanguage, value);
  setAccessToken(String value) async => await _preferences?.setString(_accessToken, value);
  setRefreshToken(String value) async => await _preferences?.setString(_refreshToken, value);
  setFullName(String value) async => await _preferences?.setString(_fullName, value);
  setUserId(String value) async => await _preferences?.setString(_userId, value);
  setFcmToken(String value) async => await _preferences?.setString(_fcmToken, value);
  setOnBoardingPassed(bool value) async => await _preferences?.setBool(_onBoardingPassed, value);

  bool get wasAuthorizationPassed => _preferences?.getBool(_authorizationPassed) ?? false;
  bool get wasConfirmationPassed => _preferences?.getBool(_confirmationPassed) ?? false;
  bool get wasLanguagePassed => _preferences?.getBool(_setLanguagePassed) ?? false;
  bool get wasTimingPassed => _preferences?.getBool(_setTimingPassed) ?? false;
  String? get accessToken => _preferences?.getString(_accessToken);
  String? get fcmToken => _preferences?.getString(_fcmToken);
  String? get refreshToken => _preferences?.getString(_refreshToken);
  bool get wasOnBoardingPassed => _preferences?.getBool(_onBoardingPassed) ?? false;
  String? get userId => _preferences?.getString(_userId);
  String? get fullName => _preferences?.getString(_fullName);
  String? get langTitle => _preferences?.getString(_langTitle);
  String? get appLanguage => _preferences?.getString(_appLanguage);


  Future<bool?> clear() async {
    final String? fcmTokenValue = _preferences?.getString(_fcmToken);

    final bool? result = await _preferences?.clear();

    if (fcmTokenValue != null && fcmTokenValue.isNotEmpty) {
      await _preferences?.setString(_fcmToken, fcmTokenValue);
    }

    return result;
  }
}


