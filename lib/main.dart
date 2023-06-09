import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nano/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:nano/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:nano/helper/bloc_observer.dart';
import 'package:nano/localization/localization.dart';
import 'package:nano/localization/localization_constants.dart';
import 'package:nano/routes.dart';
import 'package:nano/utils/constant.dart';
import 'package:nano/utils/theme_color.dart';
import 'injection_method.dart' as im;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await im.init();
  final String defaultSystemLocale = Platform.localeName;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    initialDefaultSystemLocale: defaultSystemLocale,
  ));
}

class MyApp extends StatefulWidget {
  final String initialDefaultSystemLocale;

  const MyApp({super.key, required this.initialDefaultSystemLocale});

  static void setLocale(BuildContext context, Locale locale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state!.setLocale(locale);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale(widget.initialDefaultSystemLocale.split('_')[0]).then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => im.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => im.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: ColorsFave.primaryColor,
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: ColorsFave.primaryColor)),
          routes: Routes.routes,
          initialRoute: Constants.SPLASH,
          locale: _locale,
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          supportedLocales: const [Locale('en', 'US')]),
    );
  }
}
