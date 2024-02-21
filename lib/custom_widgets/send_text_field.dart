import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat_cubit/chat_cubit.dart';

class SendTextField extends StatelessWidget {
  const SendTextField({
    Key? key,
    required this.width,
    required this.controller,
    required this.email,
    required ScrollController scrollController,
  })  : _scrollController = scrollController,
        super(key: key);

  final double width;
  final TextEditingController controller;
  final String email;
  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Container(
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
                    padding: const EdgeInsets.only(left: 2),
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 2,
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: Colors.black,
                      size: width * 0.05,
                    ),
                    child: const Center(child: Icon(Icons.send)),
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
        ));
  }
}
