// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class ChatState {
  const ChatState();
}

//* Room
class InitDataAppState extends ChatState {}

class HasDataRoomState extends ChatState {
  final List<dynamic> listRoom;

  HasDataRoomState(this.listRoom);
}

//* Message
class GettingSourceChatState extends ChatState {}

class HasSourceChatState extends ChatState {
  final bool isOnl;
  final String idRoom;
  final User currentUser;
  final User friend;
  final List<dynamic>? sourceChat;
  final List<String>? listTime;
  HasSourceChatState({
    required this.isOnl,
    required this.idRoom,
    required this.currentUser,
    required this.friend,
    this.sourceChat,
    this.listTime,
  });
}

//* Friend
class LookingForFriendState extends ChatState {
  bool? init;
  bool? finding;
  bool? cuccessed;
  bool? failed;
  List<dynamic>? requests;
  final User? user;
  bool? addFriendloading;
  bool? addFriendSuccess;
  LookingForFriendState({
    this.init = false,
    this.finding = false,
    this.cuccessed = false,
    this.failed = false,
    this.requests,
    this.user,
    this.addFriendloading,
    this.addFriendSuccess,
  });
}
