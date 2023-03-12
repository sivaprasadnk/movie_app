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
    apiKey: 'AIzaSyAXpzP1-WikDeEswIgLTZSsGE2wrytjbuI',
    appId: '1:482990802190:web:c63ea5a1fba390eb96435f',
    messagingSenderId: '482990802190',
    projectId: 'movie-app-invenics',
    authDomain: 'movie-app-invenics.firebaseapp.com',
    storageBucket: 'movie-app-invenics.appspot.com',
    measurementId: 'G-V3X53R5HB6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKQ7Esao7zTNA8GJ8PQgWR2yLFgO_Tc2E',
    appId: '1:482990802190:android:ad77d9ed6103613f96435f',
    messagingSenderId: '482990802190',
    projectId: 'movie-app-invenics',
    storageBucket: 'movie-app-invenics.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmvtPfOBnYu2IwJHEwU3gqrRP4-3JyGZI',
    appId: '1:482990802190:ios:939db38407fc943496435f',
    messagingSenderId: '482990802190',
    projectId: 'movie-app-invenics',
    storageBucket: 'movie-app-invenics.appspot.com',
    androidClientId: '482990802190-mkk9heuaeqkofc6tn8s6a6drmqp8fg4o.apps.googleusercontent.com',
    iosClientId: '482990802190-qqovq9s8b7rdle1snmr57o3b2f66d5bj.apps.googleusercontent.com',
    iosBundleId: 'com.sptpra.movieApp',
  );
}
