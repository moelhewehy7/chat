import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  Future signUp({required String email, required String password}) async {
    emit(SignupLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignupSuccess());

      /// send email  to chat page as a argument ,to show the data according to the signed one
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(Signupfailure(
            errormessage1: "Error",
            errormessage2: "Email already exists",
            errormessage3: "Ok"));
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
