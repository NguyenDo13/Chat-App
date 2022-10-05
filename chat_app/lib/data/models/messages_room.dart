// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/user.dart';

class MessageRoom {
  String? sId;
  List<Message> messages; 
  String? lastMessage;
  List<User> users;
  String? typeLastMessage;
  String? timeLastMessage;
  MessageRoom({
    this.sId,
    required this.messages,
    this.lastMessage,
    required this.users,
    this.typeLastMessage,
    this.timeLastMessage,
  });
}
