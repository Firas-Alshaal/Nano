import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nano/bloc/auth/auth_bloc.dart';
import 'package:nano/bloc/auth/auth_event.dart';
import 'package:nano/bloc/auth/auth_state.dart';
import 'package:nano/utils/constant.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthBloc authBloc;

  @override
  initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);

    Future.delayed(const Duration(seconds: 2), () {
      authBloc.add(const AuthRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: authBloc,
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, Constants.HomeScreen);
            } else if (state is NoAuthenticated) {
              Navigator.pushReplacementNamed(context, Constants.LoginScreen);
            }
          },
        ),
      ],
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [ColorsFave.secondColor, ColorsFave.primaryColor],
          )),
          child: Center(child: Image.asset(Images.logo)),
        ),
      ),
    );
  }
}
