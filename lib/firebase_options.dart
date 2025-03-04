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
    apiKey: 'AIzaSyBHJHx9OsaFtEbaP_RYQX_GsZxl1vL-c8Y',
    appId: '1:960652171424:web:2e56befa479a5d186691c5',
    messagingSenderId: '960652171424',
    projectId: 'test-notification-af33b',
    authDomain: 'test-notification-af33b.firebaseapp.com',
    storageBucket: 'test-notification-af33b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB25zWIoOA1YQqZv3z4iph0IAW1dMBFSAs',
    appId: '1:960652171424:android:8a0be97347e2e3cc6691c5',
    messagingSenderId: '960652171424',
    projectId: 'test-notification-af33b',
    storageBucket: 'test-notification-af33b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8YjVQeq-ugYlNYFitjeomvFFJziT5C6c',
    appId: '1:960652171424:ios:364ad99332497b946691c5',
    messagingSenderId: '960652171424',
    projectId: 'test-notification-af33b',
    storageBucket: 'test-notification-af33b.appspot.com',
    iosBundleId: 'com.example.trakingApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8YjVQeq-ugYlNYFitjeomvFFJziT5C6c',
    appId: '1:960652171424:ios:364ad99332497b946691c5',
    messagingSenderId: '960652171424',
    projectId: 'test-notification-af33b',
    storageBucket: 'test-notification-af33b.appspot.com',
    iosBundleId: 'com.example.trakingApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHJHx9OsaFtEbaP_RYQX_GsZxl1vL-c8Y',
    appId: '1:960652171424:web:c42101c75c824c236691c5',
    messagingSenderId: '960652171424',
    projectId: 'test-notification-af33b',
    authDomain: 'test-notification-af33b.firebaseapp.com',
    storageBucket: 'test-notification-af33b.appspot.com',
  );
}
