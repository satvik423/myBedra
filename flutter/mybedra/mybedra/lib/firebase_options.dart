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
    apiKey: 'AIzaSyARg4x-JDpJ0UlRj0CKHf8Zk5xW-9yOKHI',
    appId: '1:733856306376:web:96957fab8bca9e1c2b81fd',
    messagingSenderId: '733856306376',
    projectId: 'mybedraauth',
    authDomain: 'mybedraauth.firebaseapp.com',
    storageBucket: 'mybedraauth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCVLHpusxIQr-ejCVfo-FagCJJHqgw6pE',
    appId: '1:733856306376:android:9f5f417c3e2428612b81fd',
    messagingSenderId: '733856306376',
    projectId: 'mybedraauth',
    storageBucket: 'mybedraauth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpML8QUKNp1_1Mhh0EgLPFHEw54idBfnQ',
    appId: '1:733856306376:ios:871ca616b51b4bdf2b81fd',
    messagingSenderId: '733856306376',
    projectId: 'mybedraauth',
    storageBucket: 'mybedraauth.appspot.com',
    iosClientId: '733856306376-hpc7ep8tagi3pp26pqflicoel35sao3t.apps.googleusercontent.com',
    iosBundleId: 'com.example.mybedra',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpML8QUKNp1_1Mhh0EgLPFHEw54idBfnQ',
    appId: '1:733856306376:ios:1bb5bf2d3dadd7dd2b81fd',
    messagingSenderId: '733856306376',
    projectId: 'mybedraauth',
    storageBucket: 'mybedraauth.appspot.com',
    iosClientId: '733856306376-mesrqgpeue0fr8fr050rlp18snf78lud.apps.googleusercontent.com',
    iosBundleId: 'com.example.mybedra.RunnerTests',
  );
}
