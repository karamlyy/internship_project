// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDLGAWeLK8HcrZ9tOK6MRmaMDjvNDKtc24',
    appId: '1:930030718720:web:82850fa929eb5b0ffd6de5',
    messagingSenderId: '930030718720',
    projectId: 'learn-language-e8255',
    authDomain: 'learn-language-e8255.firebaseapp.com',
    storageBucket: 'learn-language-e8255.firebasestorage.app',
    measurementId: 'G-RG4KC4YDMV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUxJXszJvzlF8dq4sBh64AvzOXXx9MVAo',
    appId: '1:930030718720:android:3275c21dbb225c4efd6de5',
    messagingSenderId: '930030718720',
    projectId: 'learn-language-e8255',
    storageBucket: 'learn-language-e8255.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCjJBvSZD-OyRBGWzq2NBqVu3i-nTmn99Q',
    appId: '1:930030718720:ios:d158ef705ce4c35afd6de5',
    messagingSenderId: '930030718720',
    projectId: 'learn-language-e8255',
    storageBucket: 'learn-language-e8255.firebasestorage.app',
    iosBundleId: 'com.example.languageLearning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCjJBvSZD-OyRBGWzq2NBqVu3i-nTmn99Q',
    appId: '1:930030718720:ios:d158ef705ce4c35afd6de5',
    messagingSenderId: '930030718720',
    projectId: 'learn-language-e8255',
    storageBucket: 'learn-language-e8255.firebasestorage.app',
    iosBundleId: 'com.example.languageLearning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLGAWeLK8HcrZ9tOK6MRmaMDjvNDKtc24',
    appId: '1:930030718720:web:e397a2861940146cfd6de5',
    messagingSenderId: '930030718720',
    projectId: 'learn-language-e8255',
    authDomain: 'learn-language-e8255.firebaseapp.com',
    storageBucket: 'learn-language-e8255.firebasestorage.app',
    measurementId: 'G-TNC85JE5EL',
  );
}
