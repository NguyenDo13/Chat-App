// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class ChatState {
  const ChatState();
}

class InitDataRoomState extends ChatState {}

class HasDataRoomState extends ChatState {
  final List<dynamic> listRoom;

  HasDataRoomState(this.listRoom);
}

class GettingSourceChatState extends ChatState {}

class HasSourceChatState extends ChatState {
  final User currentUser;
  final User friend;
  final List<dynamic> sourceChat;
  HasSourceChatState({
    required this.currentUser,
    required this.friend,
    required this.sourceChat,
  });
}
