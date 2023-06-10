// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:nano/repository/authRepo/auth.dart';
import 'package:nano/utils/constant.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;

  AuthBloc({required this.authApi}) : super(AuthInitial()) {
    on<AuthRequested>((event, emit) async {
      emit(AuthLoadInProgress());
      try {
        if (Constants.pref.containsKey(Constants.TOKEN)) {
          emit(Authenticated());
        } else {
          emit(NoAuthenticated());
        }
      } catch (_) {
        emit(AuthLoadFailure());
      }
    });
    on<LoginRequested>((event, emit) async {
      await _postLogin(event, emit);
    });
  }

  Future<void> _postLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadInProgress());
    try {
      var data = {
        'username': event.name,
        'password': event.password,
      };
      Response res = await authApi.login(data);
      if (res.statusCode == 200) {
        Constants.pref
            .setString(Constants.TOKEN, json.decode(res.body)['token']);
        emit(Authenticated());
      } else {
        emit(NoAuthenticated(message: 'Please try again'));
      }
    } catch (e) {
      emit(AuthLoadFailure(error: (e.toString())));
    }
  }
}
