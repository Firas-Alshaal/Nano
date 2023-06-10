import 'package:flutter/material.dart';
import 'package:nano/screen/auth/login_screen.dart';
import 'package:nano/screen/auth/splash_screen.dart';
import 'package:nano/screen/homePage/home_page.dart';
import 'package:nano/utils/constant.dart';

class Routes {
  static const _splash = SplashScreen();
  static const _loginScreen = LoginPage();
  static final _homePage = HomePage(pageIndex: 0);

  static final routes = <String, WidgetBuilder>{
    Constants.SPLASH: (BuildContext context) => _splash,
    Constants.HomeScreen: (BuildContext context) => _homePage,
    Constants.LoginScreen: (BuildContext context) => _loginScreen,
  };
}
