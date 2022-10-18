// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/auth_user.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class GetDataRoomsEvent extends ChatEvent {}

class UpdateRoomsEvent extends ChatEvent {}

class SeenRoomEvent extends ChatEvent {}

class CreateRoomEvent extends ChatEvent {}

class ExitRoomEvent extends ChatEvent {}

class OnRoomEvent extends ChatEvent {
  final String roomID;
  final User friend;
  OnRoomEvent({
    required this.roomID,
    required this.friend,
  });
}
