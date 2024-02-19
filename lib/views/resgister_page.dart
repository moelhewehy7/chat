import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubits/Signup_cubit/signup_cubit.dart';
import 'package:scholar_chat/custom_widgets/custom%20_container.dart';
import 'package:scholar_chat/views/chat_page.dart';
import 'package:scholar_chat/custom_widgets/custom_button.dart';

import '../constants.dart';
import '../helper/showalert.dart';
import '../custom_widgets/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  static String id =
      "Register"; //Static variables belong to the class itself  You can use this id variable to reference the "Register" page ,
  // if i we didnt use static so everytime it will create ananoymus object
  String? email, password;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  var sui = null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.of(context)
              .pushReplacementNamed(ChatPage.id, arguments: email);
        }
        if (state is Signupfailure) {
          showAlert(context, state.errormessage1, state.errormessage2,
              state.errormessage3);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kPrimaryColor,
          body: ListView(children: [
            const CustomConatiner(
              text1: ("Register"),
              text2: ("Create your account"),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
                key: formstate,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextFormField(
                              label: "Email",
                              onchanged: (text) {
                                email = text;
                              },
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please enter your email.';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(text)) {
                                  return 'Invalid email format.';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                              obscureText: true,
                              label: "Password",
                              onchanged: (text) {
                                password = text;
                              },
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Please enter your password.';
                                }
                                if (text.length < 6) {
                                  return "Password should be at least 6 characters with numbers";
                                }

                                if (!text.contains(RegExp(r'[0-9]'))) {
                                  return "Your password must contain at least one number.";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          //the usage of the if statement within the children list of the Column widget
                          // is a way to conditionally include or exclude widgets from the list based on a certain condition.
                          if (state is SignupLoading)
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              child: const SpinKitCircle(
                                color: Color.fromARGB(255, 56, 103, 128),
                                size: 20.0,
                              ),
                            )
                          else
                            CustomButon(
                              onpressed: () async {
                                if (formstate.currentState!.validate()) {
                                  BlocProvider.of<SignupCubit>(context).signUp(
                                    email: email!,
                                    password: password!,
                                  );
                                }
                              },
                              text: "Register",
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                      context); //to return just one time
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Color(0xff7f736a),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )
                        ]))),
          ]),
        );
      },
    );
  }
}
