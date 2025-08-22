// part of 'login_bloc.dart';

// sealed class LoginState extends Equatable {
//   const LoginState();

//   @override
//   List<Object> get props => [];
// }

// final class LoginInitial extends LoginState {}

import 'package:equatable/equatable.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String userId;

  LoginSuccess(this.userId);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
