import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future signin({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaliure(
            errormessage1: "Can't find account",
            errormessage2:
                "We couldn't find your account. Please try another email, or if you don't have an account,you can sign up",
            errormessage3: "Ok"));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaliure(
            errormessage1: "Incorrect Password",
            errormessage2: "The password you entered is incorrect",
            errormessage3: "Try again"));
      }
    }
  }
}
