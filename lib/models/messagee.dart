import 'package:scholar_chat/constants.dart';

class Message {
  final String messagee;
  final String id;

  Message(this.messagee, this.id);

  factory Message.fromJson(jsonData) {
    // jsonData is the body that has the data
    return Message(
        jsonData[kMessage] ?? '', // ?? ''This is the null-aware operator
        jsonData["id"] ?? ""); //key = "message" elly e7na 3ayzeno w "id"
  }
}
