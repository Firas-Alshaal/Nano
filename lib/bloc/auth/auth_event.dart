import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthRequested extends AuthEvent {
  const AuthRequested();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String name;
  final String password;

  const LoginRequested({required this.name, required this.password});

  @override
  List<Object> get props => [];
}
