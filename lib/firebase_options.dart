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
    apiKey: 'AIzaSyCXLwmLC2Yo_ffkbmf2DLwtO51JJpuwnhw',
    appId: '1:75203046548:web:0138da717903d344d45881',
    messagingSenderId: '75203046548',
    projectId: 'literahub-8706f',
    authDomain: 'literahub-8706f.firebaseapp.com',
    storageBucket: 'literahub-8706f.appspot.com',
    measurementId: 'G-EC0EPL628Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuycNu2z42Xx-VVuOMBa3nzF_skD_nDNg',
    appId: '1:75203046548:android:5e56b8f0a606f9f5d45881',
    messagingSenderId: '75203046548',
    projectId: 'literahub-8706f',
    storageBucket: 'literahub-8706f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJJvEy4MEhnDv3pgA49XPuKo9UspEc8Cg',
    appId: '1:75203046548:ios:c5a5413c5dc2abbfd45881',
    messagingSenderId: '75203046548',
    projectId: 'literahub-8706f',
    storageBucket: 'literahub-8706f.appspot.com',
    iosBundleId: 'com.zeelearn.literahub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJJvEy4MEhnDv3pgA49XPuKo9UspEc8Cg',
    appId: '1:75203046548:ios:8f832180ae9b6036d45881',
    messagingSenderId: '75203046548',
    projectId: 'literahub-8706f',
    storageBucket: 'literahub-8706f.appspot.com',
    iosBundleId: 'com.zeelearn.literahub.RunnerTests',
  );
}
