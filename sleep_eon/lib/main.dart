import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleep_eon/feature_splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAkxdGGPeE7BZ_P_RJba1EsoDPwlOXO5vQ",
            appId: "1:81714561767:web:ac45b0e760f461d81e1842",
            messagingSenderId: "81714561767",
            projectId: "sleep-eon",
            storageBucket: "sleep-eon.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0XFF0A0E21),
        accentColor: Color(0XFFFFFFFF),
        scaffoldBackgroundColor: Color(0XFF0A0E21),
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

