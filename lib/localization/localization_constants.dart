import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nano/utils/constant.dart';
import 'package:nano/injection_method.dart' as im;
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';

String? getTranslated(BuildContext context, String key) {
  return Localization.of(context)!.getTranslatedValue(key);
}

Future<Locale> setLocale(String languageCode) async {
  final SharedPreferences sharedPreferences = im.sl();
  sharedPreferences.setString(Constants.LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(languageCode) {
  Locale temp;
  switch (languageCode) {
    case 'en':
      temp = Locale(languageCode, 'US');
      break;
    default:
      temp = Locale(languageCode, 'US');
  }
  return temp;
}

Future<Locale> getLocale(langMobile) async {
  final SharedPreferences sharedPreferences = im.sl();
  String lang;
  if (!sharedPreferences.containsKey(Constants.LANGUAGE_CODE)) {
    lang = langMobile;
  } else {
    lang = sharedPreferences.getString(Constants.LANGUAGE_CODE)!;
  }
  sharedPreferences.setString(Constants.LANGUAGE_CODE, lang);
  return _locale(lang);
}
