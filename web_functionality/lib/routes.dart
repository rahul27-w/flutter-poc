
import 'package:flutter_web_sharedpreferences/views/functionality_screen.dart';
import 'package:flutter_web_sharedpreferences/views/home_view.dart';
import 'package:flutter_web_sharedpreferences/views/loader_view.dart';
import 'package:flutter_web_sharedpreferences/views/login_view.dart';
import 'package:flutter_web_sharedpreferences/views/over_scrolling.dart';
import 'package:flutter_web_sharedpreferences/views/splash_view.dart';
import 'views/obscure_text.dart';
import 'views/scroll_test.dart';
import 'views/select_text.dart';

const String SplashRoute = "/splash";
const String FunctionalityRoute = "/functionality";
const String HomeRoute = "/home";
const String LoginRoute = "/login";
const String ObsureRoute = "/obsure";
const String OverScrollingRoute = "/overScrolling";
const String ScrollTestRoute = "/ScrollTest";
const String TextSelectionRoute = "/textSelection";
const String LoaderRoute = "/loaderView";

final routes = {
  SplashRoute: (context) => SplashView(),
  FunctionalityRoute: (context) => FunctionalityScreen(),
  HomeRoute: (context) => HomeView(),
  LoginRoute: (context) => LoginView(),
  ObsureRoute: (context) => ObscureText(title: 'Obscure text'),
  OverScrollingRoute: (context) => OverScrolling(),
  ScrollTestRoute: (context) => ScrollTest(),
  TextSelectionRoute: (context) => SelectText(),
  LoaderRoute: (context) => LoaderView(),
};
