import 'package:bloc/bloc.dart';
import 'package:bulk_basket/bloc/register/register_event.dart';
import 'package:bulk_basket/bloc/register/register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPresssed>(_registerButtonPresssed);
  }

  void _registerButtonPresssed(
      RegisterButtonPresssed event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    // if (event.email.isEmpty ||
    //     event.password.isEmpty ||
    //     event.name.isEmpty ||
    //     event.address.isEmpty) {
    //   emit(RegisterError('All Information are required'));

    //   return;
    // }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'Name': event.name, 'Address': event.address});

      emit(RegisterSuccess(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(e.message ?? 'Failed to Register'));
    }
  }
}
