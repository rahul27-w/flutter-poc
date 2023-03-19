import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sleep_eon/feature_login/login_page.dart';
import 'package:sleep_eon/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.darkBlue,
      body: Center(
        child: Image.asset('assets/images/sleepEon.png'),
      ),
    );
  }
}
