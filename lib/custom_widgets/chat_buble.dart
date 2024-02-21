import 'package:flutter/material.dart';
import 'package:scholar_chat/models/messagee.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 12, top: 10, bottom: 10, right: 15),
        margin: const EdgeInsets.only(right: 10, top: 2, left: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color.fromARGB(255, 28, 119, 245),
        ),
        child: Text(
          message.messagee,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Roboto",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);
  final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 12),
        margin: const EdgeInsets.only(right: 10, top: 2, left: 10),
        decoration: const BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
          message!.messagee,
          style: const TextStyle(fontSize: 16, fontFamily: "Roboto"),
        ),
      ),
    );
  }
}
//if we wrote it message.toString() it will show instance of Message so we will have to type @override
// String toString() {
// return messagee;  to the model page sor just wrote here message.messagee
//}