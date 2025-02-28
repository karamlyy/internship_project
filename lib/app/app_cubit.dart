import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning/app/app_state.dart';
import 'package:language_learning/data/endpoint/auth/fcm_token_endpoint.dart';
import 'package:language_learning/data/repository/language_repository.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(Splash()) {
    checkAppState();
  }

  final _languageRepository = getIt<UserConfigurationRepository>();

  void passOnboarding() async {
    final prefs = await PreferencesService.instance;
    prefs.setOnBoardingPassed(true);
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


  Future<void> checkAppState() async {
    final prefs = await PreferencesService.instance;

    try {
      if (!prefs.wasOnBoardingPassed) {
        emit(Onboarding());
        return;
      }

      // if (prefs.wasConfirmationPassed && !prefs.wasLanguagePassed && !prefs.wasTimingPassed) {
      //   emit(LanguageNeeded());
      //   return;
      // }
      // if (prefs.wasConfirmationPassed && prefs.wasLanguagePassed && !prefs.wasTimingPassed) {
      //   emit(TimingNeeded());
      //   return;
      // }

      if(prefs.wasAuthorizationPassed){
        emit(Authorized());
        await setFcmToken();
        return;
      }

      if (!prefs.wasAuthorizationPassed) {
        emit(Unauthorized());
        return;
      }





      emit(Authorized());

      await setFcmToken();
    } catch (error) {
      prefs.clear();
      emit(Splash());
    }
  }
}
