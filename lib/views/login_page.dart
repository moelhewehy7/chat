import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scholar_chat/custom_widgets/custom_container.dart';
import 'package:scholar_chat/helper/showalert.dart';
import 'package:scholar_chat/views/resgister_page.dart';
import 'package:scholar_chat/custom_widgets/custom_button.dart';

import '../constants.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../custom_widgets/custom_text_field.dart';
import '../custom_widgets/signin_choices_container.dart';
import 'chat_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  static String id = "Login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Static variables belong to the class itself  You can use this id variable to reference the "Login" page ,
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  String? email, password;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomConatiner(
                  text1: ("Sign in to your Account"),
                  text2: ("Sign in to your Account"),
                ),
                const SizedBox(
                  height: 10,
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
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
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
                                  return const SpinKitCircle(
                                    color: Color(0xFF386780),
                                    size: 20.0,
                                  );
                                } else {
                                  return CustomButon(
                                    onpressed: () async {
                                      if (formstate.currentState!.validate()) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .signin(
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
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
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
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SigninChoicesContainer(
                                    image: "assets/images/google.png",
                                    text: "Google",
                                    height: height,
                                    width: width),
                                SigninChoicesContainer(
                                    image: "assets/images/facebook.png",
                                    text: "Facebook",
                                    height: height,
                                    width: width),
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
                                        color:
                                            Color.fromARGB(235, 127, 115, 106),
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
        ),
      ),
    );
  }
}


//"We couldn't find your account. Please try another email, or  if you don't have an account,  you can sign up"
//"Incorrect Password. The password you entered is incorrect. please try again"
