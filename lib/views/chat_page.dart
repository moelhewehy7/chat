import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/custom_widgets/chat_buble.dart';
import 'package:scholar_chat/custom_widgets/signout_alert_dialog.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = "ChatPage";

  TextEditingController controller = TextEditingController();

  final _scrollController = ScrollController();

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var email = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint(email);
    return PopScope(
      canPop: false,
      onPopInvoked: ((didPop) {
        signoutAlertdialog(context);
      }),
      child: Scaffold(
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
          flexibleSpace:
              Container(decoration: const BoxDecoration(color: Colors.white)),
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
                  Color(0xFFF6EEE9),
                  BlendMode.modulate,
                ),
                child: Image.asset(
                  "assets/images/suo.jpeg",
                  height: double.infinity,
                  fit: BoxFit.fill,
                )),
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagelist =
                    BlocProvider.of<ChatCubit>(context).messagelist;
                return ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(bottom: height * 0.09),
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messagelist.length,
                  itemBuilder: (context, i) {
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: width * 0.8,
                  child: TextFormField(
                    maxLines: null,
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    cursorColor: const Color(0xFF5A5959),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: sendMessageButton(width, context, email),
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
      ),
    );
  }

  Container sendMessageButton(
      double width, BuildContext context, String email) {
    return Container(
      width: width * 0.09,
      height: width * 0.09,
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
            // ignore: avoid_returning_null_for_void
            return null;
            // disable the send button// because the message is empty
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12.0),
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 2,
        ),
        child: const IconTheme(
          data: IconThemeData(
            color: Colors.black,
            size: 22,
          ),
          child: Icon(Icons.send),
        ),
      ),
    );
  }
}
