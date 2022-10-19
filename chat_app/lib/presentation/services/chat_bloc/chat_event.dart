// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class ChatEvent {
  const ChatEvent();
}

// Room
class GetDataRoomsEvent extends ChatEvent {}

class ExitRoomEvent extends ChatEvent {}

class OnRoomEvent extends ChatEvent {
  final String roomID;
  final User friend;
  final bool isOnl;
  OnRoomEvent({
    required this.roomID,
    required this.friend,
    required this.isOnl,
  });
}

// Message
class SendMessageEvent extends ChatEvent {
  final String message;
  final String idRoom;
  final String idTarget;
  SendMessageEvent({
    required this.message,
    required this.idRoom,
    required this.idTarget,
  });
}
