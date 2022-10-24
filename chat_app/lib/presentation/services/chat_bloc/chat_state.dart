// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class ChatState {
  const ChatState();
}

//* Room
class InitDataRoomState extends ChatState {}

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
  final dynamic sourceChat;
  HasSourceChatState({
    required this.isOnl,
    required this.idRoom,
    required this.currentUser,
    required this.friend,
    this.sourceChat,
  });
}

//* Friend
class LookingForFriendState extends ChatState {
  bool? init;
  bool? finding;
  bool? cuccessed;
  bool? failed;
  final User? user;
  LookingForFriendState({
    this.init = false,
    this.finding = false,
    this.cuccessed = false,
    this.failed = false,
    this.user,
  });
}
