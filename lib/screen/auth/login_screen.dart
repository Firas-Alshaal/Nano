import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nano/bloc/auth/auth_bloc.dart';
import 'package:nano/bloc/auth/auth_event.dart';
import 'package:nano/bloc/auth/auth_state.dart';
import 'package:nano/helper/dismiss_keyboard.dart';
import 'package:nano/repository/authRepo/auth.dart';
import 'package:nano/screen/homePage/home_page.dart';
import 'package:nano/utils/images.dart';
import 'package:nano/utils/theme_color.dart';
import 'package:nano/widget/alert/api_response_alert.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthBloc authBloc;
  AuthApi authApi = AuthApi(httpClient: http.Client());
  var formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? passwordErrorText;

  String? userErrorText;

  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: authBloc,
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return HomePage();
              },
            ),
            (_) => false,
          );
        } else if (state is NoAuthenticated) {
          alertFromApiFailure(context, state.message!);
        }
      },
      child: DismissKeyboard(
        child: Scaffold(
          backgroundColor: ColorsFave.backgroundColor,
          resizeToAvoidBottomInset: true,
          body: BlocBuilder(
              bloc: authBloc,
              builder: (context, state) {
                if (state is AuthLoadInProgress) {
                  return Center(
                    child: CircularProgressIndicator(
                        color: ColorsFave.primaryColor),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            ColorsFave.secondColor,
                            ColorsFave.primaryColor
                          ],
                        )),
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset(Images.logo),
                            ),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  child: Text('Log In',
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.w700,
                                          color: ColorsFave.backgroundColor)),
                                )..padding.add(const EdgeInsets.all(50)))
                          ],
                        ),
                      ),
                      Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 13)),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: userController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                        filled: true,
                                        suffixIcon: Icon(
                                          size: 17,
                                          Icons.check_circle,
                                          color: HexColor('#56C0C1'),
                                        ),
                                        errorText: userErrorText,
                                        fillColor: Colors.white,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: HexColor('#3C3C435C'),
                                          ),
                                        ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red),
                                        ),
                                        focusedErrorBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: HexColor('#3C3C435C'),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return userErrorText =
                                              'Enter your email please';
                                        } else {
                                          userErrorText = null;
                                        }
                                        return userErrorText;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Password',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 13)),
                                    TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      obscureText: isVisible ? false : true,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                        filled: true,
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          child: Icon(
                                            size: 20,
                                            isVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: HexColor('#000000')
                                                .withOpacity(0.15),
                                          ),
                                        ),
                                        errorText: passwordErrorText,
                                        fillColor: Colors.white,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: HexColor('#3C3C435C'),
                                          ),
                                        ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red),
                                        ),
                                        focusedErrorBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.red),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: HexColor('#3C3C435C'),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return passwordErrorText =
                                              'Enter your password please';
                                        } else {
                                          passwordErrorText = null;
                                        }
                                        return passwordErrorText;
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorsFave.primaryColor,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 18),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(43)),
                                        ),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            authBloc.add(LoginRequested(
                                                name: userController.text,
                                                password:
                                                    passwordController.text));
                                          }
                                        },
                                        child: FittedBox(
                                          child: Text('Confirm',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'NEED HELP?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
