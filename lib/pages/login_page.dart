import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scholar_chat/custom_widgets/custom%20_container.dart';
import 'package:scholar_chat/helper/showalert.dart';
import 'package:scholar_chat/pages/resgister_page.dart';
import 'package:scholar_chat/custom_widgets/custom_button.dart';

import '../constants.dart';
import '../cubits/chat_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../custom_widgets/custom_text_field.dart';
import 'chat_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static String id =
      "Login"; //Static variables belong to the class itself  You can use this id variable to reference the "Login" page ,
  // if i we didnt use static so everytime it will create ananoymus object

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Call the getmessage method to populate the messagelist
            BlocProvider.of<ChatCubit>(context).getmessage();
            Navigator.of(context)
                .pushReplacementNamed(ChatPage.id, arguments: email);
          } else if (state is LoginFaliure) {
            showAlert(context, state.errormessage1, state.errormessage2,
                state.errormessage3);
          }
        },
        child: ListView(
          children: [
            const CustomConatiner(
              text1: ("Sign in to your Account"),
              text2: ("Sign in to your Account"),
            ),
            SizedBox(
              height: 50,
            ),
            // SizedBox(
            //   height: 50,
            // ),
            Form(
              key: formstate,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTextFormField(
                            label: "Email",
                            onchanged: (text) {
                              email = text;
                            },
                            Validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter your email.';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(text)) {
                                return 'Invalid email format.';
                              }
                              return null;
                            }),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        CustomTextFormField(
                            obscureText: true,
                            label: "Password",
                            onchanged: (text) {
                              password = text;
                            },
                            Validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Please enter your password.';
                              }

                              return null;
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Forgot Passowrd?",
                          style: TextStyle(
                              color: Color(0xff7f736a),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return SpinKitCircle(
                                color: Color.fromARGB(255, 56, 103, 128),
                                size: 20.0,
                              );
                            } else {
                              return CustomButon(
                                onpressed: () async {
                                  if (formstate.currentState!.validate()) {
                                    BlocProvider.of<LoginCubit>(context).signin(
                                      email: email!,
                                      password: password!,
                                    );
                                  }
                                },
                                text: "Login",
                              );
                            }
                          },
                        ), //When the state is LoginLoading,
                        //the SpinKitCircle widget is returned, indicating that the loading indicator should be shown. Otherwise,
                        //when the state is not LoginLoading,
                        //the CustomButton widget is returned, indicating that the button should be shown.
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 1,
                              width: 110,
                              color: Colors.grey,
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Or login with',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: 110,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: 175,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/google.png",
                                    scale: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Google",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffcbcecf),
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 175,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/facebook.png",
                                    scale: 30,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Facebook",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xffcbcecf),
                                  width: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Dont have an account?"),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Register.id);
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Color.fromARGB(235, 127, 115, 106),
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )
                      ])),
            )
          ],
        ),
      ),
    );
  }

  /*  Future signin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      Navigator.of(context).pushReplacementNamed(ChatPage.id,
          arguments:
              email); //// send email  to chat page as a argument ,to show the data according to the signed one
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return showalert(
            context,
            "Can't find account",
            "We couldn't find your account. Please try another email, or if you don't have an account,you can sign up",
            "Ok");
      } else if (e.code == 'wrong-password') {
        showalert(context, "Incorrect Password",
            "The password you entered is incorrect", "TRY AGAIN");
      }
    }
  } */
}
//"We couldn't find your account. Please try another email, or  if you don't have an account,  you can sign up"
//"Incorrect Password. The password you entered is incorrect. please try again"
