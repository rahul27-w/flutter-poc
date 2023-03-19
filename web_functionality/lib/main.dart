import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_sharedpreferences/routes.dart';
import 'package:flutter_web_sharedpreferences/views/login_view.dart';

import 'views/functionality_screen.dart';
import 'views/obscure_text.dart';
import 'views/over_scrolling.dart';
import 'views/select_text.dart';

void main() {
  runApp(MyApp());
  FirebaseMessaging.instance.getToken().then(print);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FunctionalityRoute,
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SelectText(),
    );
  }
}
