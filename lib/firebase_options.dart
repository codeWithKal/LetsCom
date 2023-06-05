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
    apiKey: 'AIzaSyDVI_VCPDns1cS40lTVctOCkAy9KfsAer8',
    appId: '1:503775379383:web:772c7384f5c4eb887c7232',
    messagingSenderId: '503775379383',
    projectId: 'letscom-df858',
    authDomain: 'letscom-df858.firebaseapp.com',
    storageBucket: 'letscom-df858.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaxDSnGORG7SmkTkIJq68B9B5TIS0VEtI',
    appId: '1:503775379383:android:4de6fe0db02b8e377c7232',
    messagingSenderId: '503775379383',
    projectId: 'letscom-df858',
    storageBucket: 'letscom-df858.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk2obJhieHTRlEuLd1GVWa0nV3yOmPy8s',
    appId: '1:503775379383:ios:698270fa185dfda47c7232',
    messagingSenderId: '503775379383',
    projectId: 'letscom-df858',
    storageBucket: 'letscom-df858.appspot.com',
    iosBundleId: 'com.example.letsCom',
  );
}
