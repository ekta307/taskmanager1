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
    apiKey: 'AIzaSyDQd38AuAQTvuVUZ3gFziDIhxIGadqxxRA',
    appId: '1:127926109877:web:e10fb2bbd6c8263dcca0fc',
    messagingSenderId: '127926109877',
    projectId: 'taskmanagement3007',
    authDomain: 'taskmanagement3007.firebaseapp.com',
    storageBucket: 'taskmanagement3007.firebasestorage.app',
    measurementId: 'G-9Z3XESVCXN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzc_48nqdjX55s_FZfzQntfKefWlkVWlo',
    appId: '1:127926109877:android:18153dd9f38e64accca0fc',
    messagingSenderId: '127926109877',
    projectId: 'taskmanagement3007',
    storageBucket: 'taskmanagement3007.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3Fq_w9hWeNgYVqgXP0E8oqjw4jqhApiw',
    appId: '1:127926109877:ios:d6eb79458a6b7c2ccca0fc',
    messagingSenderId: '127926109877',
    projectId: 'taskmanagement3007',
    storageBucket: 'taskmanagement3007.firebasestorage.app',
    iosBundleId: 'com.example.tasksmanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3Fq_w9hWeNgYVqgXP0E8oqjw4jqhApiw',
    appId: '1:127926109877:ios:d6eb79458a6b7c2ccca0fc',
    messagingSenderId: '127926109877',
    projectId: 'taskmanagement3007',
    storageBucket: 'taskmanagement3007.firebasestorage.app',
    iosBundleId: 'com.example.tasksmanagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDQd38AuAQTvuVUZ3gFziDIhxIGadqxxRA',
    appId: '1:127926109877:web:789430efdabd1eb6cca0fc',
    messagingSenderId: '127926109877',
    projectId: 'taskmanagement3007',
    authDomain: 'taskmanagement3007.firebaseapp.com',
    storageBucket: 'taskmanagement3007.firebasestorage.app',
    measurementId: 'G-RYXVFQEN86',
  );
}
