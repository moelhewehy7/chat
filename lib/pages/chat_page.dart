import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit.dart';
import '../custom_widgets/chat_buble.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = "ChatPage";

  TextEditingController controller = TextEditingController();

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    print(email);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signoutAlertdialog(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
        elevation: 0.4,
        flexibleSpace: Container(
            height: 100, decoration: const BoxDecoration(color: Colors.white)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kscholarlogo,
              height: 55,
            ),
            const Text(
              "Scholar chat",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 246, 238, 233),
                BlendMode.modulate,
              ),
              child: Image.asset(
                "assets/images/suo.jpeg",
                height: double.infinity,
                fit: BoxFit.fill,
              )),

          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              var messagelist = BlocProvider.of<ChatCubit>(context).messagelist;
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(bottom: 75),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: messagelist.length,
                itemBuilder: (context, i) {
                  // we used i To ensure consistency,
                  // you should iterate over the retrieved messages when building the widgets.
                  return messagelist[i].id == email
                      ? ChatBuble(
                          message: messagelist[i],
                        )
                      : ChatBubleForFriend(
                          message: messagelist[i],
                        );
                },
              );
            },
          )

/* } else if (snapshot.hasError) {
                print("Error: ${snapshot.error}");
                return Center(child: Text("Somethin went wrong, please try again"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ) */
          , // Return an empty widget if the condition is not met
          //lw emaill fi id same as signed in email
          //  pass the data to message paramter ,
          //   snapshot.data.docs[i] :jsonData
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: 360,
                child: TextFormField(
                  maxLines: null,
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  cursorColor: const Color.fromARGB(255, 90, 89, 89),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            final messageText = controller.text;
                            if (messageText.isNotEmpty) {
                              BlocProvider.of<ChatCubit>(context).sendmessage(
                                message: messageText,
                                email: email,
                              );
                              controller.clear();

                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            } else {
                              return null;
                              // disable the send button
                              // because the message is empty
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 2.0,
                          ),
                          child: const IconTheme(
                            data: IconThemeData(
                              color: Colors.black,
                              size: 22,
                            ),
                            child: Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                    hintText: "    Type message...",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                )),
          )
        ],
      ),
    );
  }

  void signoutAlertdialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("Are you sure you want to sign out",
                style: TextStyle(fontSize: 21, fontFamily: "Roboto")),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Colors.white),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 47, 64, 73)),
                  )),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacementNamed(LoginPage.id);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    backgroundColor: const Color.fromARGB(255, 47, 64, 73)),
                child: const Text("Logout",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              )
            ],
          );
        });
  }
}
