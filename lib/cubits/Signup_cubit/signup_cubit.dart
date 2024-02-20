import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return emit(Signupfailure(
            errormessage1: "Error",
            errormessage2: "'The password provided is too weak.'",
            errormessage3: "Ok"));
      } else if (e.code == 'email-already-in-use') {
        emit(Signupfailure(
            errormessage1: "Error",
            errormessage2: "Email already exists",
            errormessage3: "Ok"));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
