// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA7kUcQy_oLplregrhofkhOThY5N74JIxY',
    appId: '1:315101799462:web:137829efe798b626f532e7',
    messagingSenderId: '315101799462',
    projectId: 'fir-project-dfcbc',
    authDomain: 'fir-project-dfcbc.firebaseapp.com',
    storageBucket: 'fir-project-dfcbc.appspot.com',
    measurementId: 'G-G9EBRP00LR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGHw9VOzd6UwLrJHa__xxwaANG9bUZbYQ',
    appId: '1:315101799462:android:a16558c2f94b9988f532e7',
    messagingSenderId: '315101799462',
    projectId: 'fir-project-dfcbc',
    storageBucket: 'fir-project-dfcbc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4DAOkqoMsVKQmy48GskX8rnZ0lDojznE',
    appId: '1:315101799462:ios:2feacebf7d13e709f532e7',
    messagingSenderId: '315101799462',
    projectId: 'fir-project-dfcbc',
    storageBucket: 'fir-project-dfcbc.appspot.com',
    iosBundleId: 'com.example.topfirebase',
  );
}