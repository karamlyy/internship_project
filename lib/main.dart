import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_learning/app/app.dart';
import 'package:language_learning/data/manager/notification_manager.dart';
import 'package:language_learning/data/service/api/di.dart';
import 'package:language_learning/data/service/preferences/preferences.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:ui' as ui;

import 'firebase_options.dart';
import 'utils/colors/app_colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.instance.initialize();
  await Injector.register();

  final prefs = await PreferencesService.instance;
  final deviceLanguage = ui.window.locale.languageCode;
  prefs.setLanguage(deviceLanguage);
  final savedLanguageCode = prefs.appLanguage ?? 'en';

  runApp(AuthGate(initialLang: savedLanguageCode));
}

class AuthGate extends StatelessWidget {
  final String initialLang;
  const AuthGate({super.key, required this.initialLang});

  Future<bool> authenticateUser() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        return true;
      }

      return await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Biometric authentication error: $e");
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: authenticateUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(

            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.data == true) {
          return App(initialLang: initialLang);
        } else {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 100,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Authentication Failed",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "We couldn't verify your identity.\nPlease restart the app and try again.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
