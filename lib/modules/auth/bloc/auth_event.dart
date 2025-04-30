import 'package:emcus/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SignUpSubmitted extends AuthEvent {
  final UserModel user;

  SignUpSubmitted({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignInSubmitted extends AuthEvent {
  final UserModel user;

  SignInSubmitted({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignOut extends AuthEvent {}
