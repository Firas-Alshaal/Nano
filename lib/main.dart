import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano/bloc/auth/auth_bloc.dart';
import 'package:nano/bloc/bloc_observer.dart';
import 'package:nano/bloc/home/home_bloc.dart';
import 'package:nano/repository/authRepo/auth.dart';
import 'package:nano/repository/homeRepo/home_api.dart';
import 'package:nano/routes.dart';
import 'package:nano/utils/constant.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Constants.pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthApi authApi = AuthApi(httpClient: http.Client());
  HomeApi homeApi = HomeApi(httpClient: http.Client());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authApi: authApi),
          ),
          BlocProvider(
            create: (context) => HomeBloc(homeApi: homeApi),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: ColorsFave.primaryColor,
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: ColorsFave.primaryColor)),
          routes: Routes.routes,
          initialRoute: Constants.SPLASH,
        ));
  }
}
