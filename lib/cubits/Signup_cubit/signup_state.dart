part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

// ignore: must_be_immutable
class Signupfailure extends SignupState {
  String errormessage1;
  String errormessage2;
  String errormessage3;

  Signupfailure({
    required this.errormessage1,
    required this.errormessage2,
    required this.errormessage3,
  });
}
