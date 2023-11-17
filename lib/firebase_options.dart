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
        return macos;
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
    apiKey: 'AIzaSyBXwruKLdNejp9z1Gv2wdJ846CiOcEaQy0',
    appId: '1:104229354879:web:3ab26738032ce759582e4a',
    messagingSenderId: '104229354879',
    projectId: 'likely-15bcc',
    authDomain: 'likely-15bcc.firebaseapp.com',
    storageBucket: 'likely-15bcc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCXBmCFpIGyV9NPKklDwIgWM25oqboRONA',
    appId: '1:104229354879:android:06c120d871207545582e4a',
    messagingSenderId: '104229354879',
    projectId: 'likely-15bcc',
    storageBucket: 'likely-15bcc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRxDBRsK_YbhT1KJL9urk_H2yfImBBupg',
    appId: '1:104229354879:ios:de067447f25e42a4582e4a',
    messagingSenderId: '104229354879',
    projectId: 'likely-15bcc',
    storageBucket: 'likely-15bcc.appspot.com',
    iosBundleId: 'com.example.paMobileDating',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRxDBRsK_YbhT1KJL9urk_H2yfImBBupg',
    appId: '1:104229354879:ios:01f9b6a70447accc582e4a',
    messagingSenderId: '104229354879',
    projectId: 'likely-15bcc',
    storageBucket: 'likely-15bcc.appspot.com',
    iosBundleId: 'com.example.paMobileDating.RunnerTests',
  );
}