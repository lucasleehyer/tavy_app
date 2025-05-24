import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyDoJH4u1rt9-7or521QuID67WHLTXOhEuQ",
        authDomain: "tavy-app.firebaseapp.com",
        projectId: "tavy-app",
        storageBucket: "tavy-app.firebasestorage.app",
        messagingSenderId: "996757631604",
        appId: "1:996757631604:web:5479e2d2361c00dc5f1721",
        // measurementId is optional; only used for analytics
        measurementId: "G-VFFMB3YL98",
      );
    }

    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }
}

