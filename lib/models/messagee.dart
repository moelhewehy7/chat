import 'package:scholar_chat/constants.dart';

class Message {
  final String messagee;
  final String id;

  Message(this.messagee, this.id);

  factory Message.fromJson(dynamic jsonData) {
    return Message(
        jsonData[kMessage] ?? '', // ?? ''This is the null-aware operator
        jsonData["id"] ?? "");
  }
}
