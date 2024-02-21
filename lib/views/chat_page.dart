import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/custom_widgets/chat_buble.dart';
import 'package:scholar_chat/custom_widgets/signout_alert_dialog.dart';

import '../custom_widgets/send_text_field.dart';

class ChatPage extends StatefulWidget {
  static String id = "ChatPage";
  const ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  final _scrollController = ScrollController();
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
                flexibleSpace: Container(
                    decoration: const BoxDecoration(color: Colors.white)),
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(kscholarlogo, height: 55),
                  const Text(
                    "Scholar chat",
                    style: TextStyle(color: Colors.black),
                  )
                ])),
            body: Stack(children: [
              ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFF6EEE9),
                    BlendMode.modulate,
                  ),
                  child: Image.asset("assets/images/suo.jpeg",
                      height: double.infinity, fit: BoxFit.fill)),
              BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
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
                    });
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: SendTextField(
                    width: width,
                    controller: controller,
                    email: email,
                    scrollController: _scrollController),
              )
            ])));
  }
}
