// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadInProgress extends AuthState {}

class Authenticated extends AuthState {}

class NoAuthenticated extends AuthState {
  String? message;

  NoAuthenticated({this.message});
}

class AuthLoadFailure extends AuthState {
  String? error;

  AuthLoadFailure({this.error});
}
