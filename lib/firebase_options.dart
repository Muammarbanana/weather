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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdA_fB60TmvLPqbMv6Z1R3Qx-ekIt1dgg',
    appId: '1:149225895755:android:7831758b9ae7960eefdace',
    messagingSenderId: '149225895755',
    projectId: 'weatherapp-f0212',
    storageBucket: 'weatherapp-f0212.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHc7HIkak149W5ibcXHeC7O26uEszfMnU',
    appId: '1:149225895755:ios:e2533cbce4037ef5efdace',
    messagingSenderId: '149225895755',
    projectId: 'weatherapp-f0212',
    storageBucket: 'weatherapp-f0212.appspot.com',
    androidClientId: '149225895755-c7oefcbeai911vmnbhd6hgeqoqncvd3f.apps.googleusercontent.com',
    iosClientId: '149225895755-g83r0uppkivn9k7areb1toe2svreojle.apps.googleusercontent.com',
    iosBundleId: 'com.muammar.weatherapp',
  );
}
