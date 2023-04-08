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
    apiKey: 'AIzaSyAHEqwOwFM3tvMuKFJsikEdUfembep34YM',
    appId: '1:1024402602294:web:4bb1c38634cf92e6809b97',
    messagingSenderId: '1024402602294',
    projectId: 'riverpod-todo-170f4',
    authDomain: 'riverpod-todo-170f4.firebaseapp.com',
    storageBucket: 'riverpod-todo-170f4.appspot.com',
    measurementId: 'G-J01RTPX639',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4Pv-aaKoaVtTNbg76KLDMgL9d8be9iyQ',
    appId: '1:1024402602294:android:56a70d2a96dd3aad809b97',
    messagingSenderId: '1024402602294',
    projectId: 'riverpod-todo-170f4',
    storageBucket: 'riverpod-todo-170f4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDo7axFBtlz1p9nlhUz2zTCMn029OCWL4',
    appId: '1:1024402602294:ios:865bff99cfcb55ab809b97',
    messagingSenderId: '1024402602294',
    projectId: 'riverpod-todo-170f4',
    storageBucket: 'riverpod-todo-170f4.appspot.com',
    iosClientId: '1024402602294-gge0h4loej6hp3ksob2tdqbias8a595s.apps.googleusercontent.com',
    iosBundleId: 'com.example.riverpodTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDo7axFBtlz1p9nlhUz2zTCMn029OCWL4',
    appId: '1:1024402602294:ios:865bff99cfcb55ab809b97',
    messagingSenderId: '1024402602294',
    projectId: 'riverpod-todo-170f4',
    storageBucket: 'riverpod-todo-170f4.appspot.com',
    iosClientId: '1024402602294-gge0h4loej6hp3ksob2tdqbias8a595s.apps.googleusercontent.com',
    iosBundleId: 'com.example.riverpodTodo',
  );
}
