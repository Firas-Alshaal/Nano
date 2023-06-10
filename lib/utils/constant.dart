// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  Constants._();

  //PAGES
  static const String SPLASH = '/';
  static const String HomeScreen = '/home';
  static const String LoginScreen = '/loginScreen';

  //APIs
  static const String URL = 'https://fakestoreapi.com/';
  static const String LOGIN = 'auth/login';
  static const String GetProducts = 'products';

  // Shared Key
  static late SharedPreferences pref;
  static const String TOKEN = 'token';
}
