import 'package:scholar_chat/models/messagee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagelist = []; //LIST OF OBJECTS
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  void sendmessage({required String message, required String email}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), "id": email});
  }

  void getmessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagelist.clear();
      for (var doc in event.docs) {
        messagelist.add(Message.fromJson(doc));
      }
      emit(ChatSuccess());
    });
  }
} 
 
 
 
  //By using snapshots() and listen, the getMessage function ensures that the UI stays up to date
  // with the latest data from the Firestore collection messages.
  //This way, the chat interface remains synchronized with the Firestore database in real-time.
  //Using listen is appropriate when you want to establish a real-time data stream 
  //to listen for changes in a data source. 

   //messagelist.clear(); is used to prepare the list for receiving fresh messages and 
   //avoid duplication .
   //the for loop iterates over each document (doc) in event.docs
   //In the updated code, the retrieved documents in event.docs are iterated over,
   //and each document is converted to a Message object. These converted messages 
   //are then added to the messagelist.
     