import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature/feature_splash/view/splash_screen.dart';
import 'theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
