// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc() : super(LoginInitial()) {
//     on<LoginEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:bulk_basket/bloc/login/login_event.dart';
import 'package:bulk_basket/bloc/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_loginButtonPressed);
  }

  void _loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    if (event.email.isEmpty || event.password.isEmpty) {
      emit(LoginFailure('Email and Password are required'));
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);

              

      GetStorage().write('userId',userCredential.user!.uid);

      emit(LoginSuccess(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure("${e.message}" ?? "Login failed"));
    }
  }
}
