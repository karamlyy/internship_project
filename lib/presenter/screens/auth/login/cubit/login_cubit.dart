import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:language_learning/data/endpoint/auth/fcm_token_endpoint.dart';
import 'package:language_learning/data/endpoint/auth/login_endpoint.dart';
import 'package:language_learning/data/repository/auth_repository.dart';
import 'package:language_learning/data/repository/language_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';

import '../../../../../data/model/auth/login_model.dart';

class LoginCubit extends Cubit<BaseState> {
  LoginCubit() : super(InitialState());

  final _authRepository = getIt<AuthRepository>();
  final _languageRepository = getIt<UserConfigurationRepository>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void login(BuildContext context, LoginInput input) async {
    emit(LoadingState());
    final result = await _authRepository.login(input);
    final prefs = await PreferencesService.instance;
    result.fold(
      (error) => emit(FailureState(errorMessage: error.error)),
      (data) async {
        await prefs.setOnBoardingPassed(true);
        await prefs.setAccessToken(data.accessToken ?? "");
        await prefs.setRefreshToken(data.refreshToken ?? "");

        await setFcmToken();

        emit(SuccessState(data: data));
        if (data.hasLanguage == false && data.hasNotificationSetting == false) {
          Navigation.pushNamedAndRemoveUntil(Routes.setLanguage);
        } else if (data.hasLanguage == true &&
            data.hasNotificationSetting == false) {
          Navigation.pushNamedAndRemoveUntil(Routes.setTiming);
        } else if (data.hasLanguage == true &&
            data.hasNotificationSetting == true) {
          prefs.setAuthorizationPassed(true);
          context.read<HomeCubit>()
            ..getAllLanguagePairs()
            ..getCardCounts()
            ..getLastWords();
          await Navigation.pushNamedAndRemoveUntil(Routes.home);
        }
      },
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print('Google Sign-In canceled by user');
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        print("Firebase sign-in failed");
        return;
      }

      final idToken = googleSignInAuthentication.idToken;
      if (idToken != null) {
        final result = await _authRepository.signInWithGoogle(idToken);

        result.fold(
          (error) => emit(FailureState(errorMessage: error.error)),
          (data) {
            context.read<HomeCubit>()
              ..getAllLanguagePairs()
              ..getCardCounts()
              ..getLastWords();
            _handleGoogleAuthSuccess(context, data);


          },
        );
      } else {
        print("Google Sign-In failed to provide an ID token");
      }
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<void> _handleGoogleAuthSuccess(
      BuildContext context, LoginModel data) async {
    final prefs = await PreferencesService.instance;
    prefs.setOnBoardingPassed(true);
    prefs.setAccessToken(data.accessToken ?? "");
    prefs.setRefreshToken(data.refreshToken ?? "");

    await setFcmToken();

    emit(SuccessState(data: data));
    if (data.hasLanguage == false && data.hasNotificationSetting == false) {
      Navigation.pushNamedAndRemoveUntil(Routes.setLanguage);
      context.read<HomeCubit>()
        ..getAllLanguagePairs()
        ..getCardCounts()
        ..getLastWords();
    } else if (data.hasLanguage == true &&
        data.hasNotificationSetting == false) {
      context.read<HomeCubit>()
        ..getAllLanguagePairs()
        ..getCardCounts()
        ..getLastWords();
      Navigation.pushNamedAndRemoveUntil(Routes.setTiming);

    } else if (data.hasLanguage == true &&
        data.hasNotificationSetting == true) {
      prefs.setAuthorizationPassed(true);
      context.read<HomeCubit>()
        ..getAllLanguagePairs()
        ..getCardCounts()
        ..getLastWords();
      await Navigation.pushNamedAndRemoveUntil(Routes.home);

    }
  }

  Future<void> setFcmToken() async {
    final prefs = await PreferencesService.instance;
    final fcmToken = prefs.fcmToken;

    if (fcmToken != null) {
      final result = await _languageRepository
          .setFcmToken(FcmTokenInput(token: fcmToken, timeZone: 'Asia/Baku'));

      result.fold(
        (error) => print('FCM token failed to set'),
        (data) => print('FCM token set successfully'),
      );
    }
  }
}
