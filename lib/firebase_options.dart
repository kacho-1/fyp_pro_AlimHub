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
    apiKey: 'AIzaSyCE_6kXdxD_iKMr8itizFmpLsr3T3wIwUg',
    appId: '1:756928835588:web:df4eea5290f20b37f4c551',
    messagingSenderId: '756928835588',
    projectId: 'alimhub-6c7f4',
    authDomain: 'alimhub-6c7f4.firebaseapp.com',
    storageBucket: 'alimhub-6c7f4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1Dbg8J2sdVpoRN-aKYG0fC1SV_R6DMUk',
    appId: '1:756928835588:android:fd2ec0e883b0b7fcf4c551',
    messagingSenderId: '756928835588',
    projectId: 'alimhub-6c7f4',
    storageBucket: 'alimhub-6c7f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOPKbZu3S5Eep5SHYF4l_T_Psn0VIeeI0',
    appId: '1:756928835588:ios:b5fb87b55dcda2baf4c551',
    messagingSenderId: '756928835588',
    projectId: 'alimhub-6c7f4',
    storageBucket: 'alimhub-6c7f4.appspot.com',
    iosBundleId: 'com.example.fypPro',
  );
}