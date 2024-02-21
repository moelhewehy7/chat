import 'package:scholar_chat/constants.dart';

class Message {
  final String messagee;
  final String id;
  final String date;
  Message(this.messagee, this.id, this.date);

  factory Message.fromJson(dynamic jsonData) {
    return Message(
        jsonData[kMessage] ?? '', // ?? ''This is the null-aware operator
        jsonData["id"] ?? "",
        jsonData["createdAt"]);
  }
}
