part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFaliure extends LoginState {
  String errormessage1;
  String errormessage2;
  String errormessage3;

  LoginFaliure({
    required this.errormessage1,
    required this.errormessage2,
    required this.errormessage3,
  });
}
