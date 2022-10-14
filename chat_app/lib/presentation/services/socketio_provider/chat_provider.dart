// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class ChatProvider extends ChangeNotifier {
  final IO.Socket socket;

  //* get infomation another user in room
  late final ChatRepository chatRepository;
  late final User _anotherUserInRoom;
  User get anotherUserInRoom => _anotherUserInRoom;

  //* Current user
  final User currentUser;

  //* Data chat room
  final StreamController<List<ChatRoom>> _chatRoomsStream = StreamController();
  Stream<List<ChatRoom>> get chatRooms => _chatRoomsStream.stream;

  //* To Check connect server
  bool _isConnect = false;
  bool get isConnect => _isConnect;

  ChatProvider({
    required this.socket,
    required this.currentUser,
    required this.chatRepository,
  }) {
    //* Check connect to server
    checkConnectSocket();
  }

  // get user infomation in a room
  Future<User?> getInfoUserbyId(String userID) async {
    // Post request (email, password) to server, receive response value
    final value = await chatRepository.getInfoUserById(
      data: {'userID': userID},
      header: {'Content-Type': 'application/json'},
    );

    // Check correct value data
    if (value == null || value.result != 1) {
      return null;
    }

    // fetch data
    final result = chatRepository.convertDynamicToObject(value);
    return result;
  }

  // To get all Room of the current user
  getChatRooms() {
    //Check connect to server
    if (!_isConnect) return;

    // Check data(request) not null
    if (currentUser.sId == null) return;

    // // emit a event to server to get data rooms
    // socket.emit('getRooms', currentUser.sId!);
    socket.on('AllRoom', (data) {
      List<ChatRoom> listRoom = [];
      //fetch data to RoomStream
      for (var room in data) {
        final chatRoom = ChatRoom.fromJson(room);
        listRoom.add(chatRoom);
      }
      _chatRoomsStream.sink.add(listRoom);
    });
  }

  //TODO: event seen messages of room notification
  seenRoomMessages() {
    if (!_isConnect) return;
    //TODO: emit event and listen data from server
  }

  checkConnectSocket() {
    // Connected
    socket.onConnect(
      (data) {
        log("Connection established");
        _isConnect = true;
        notifyListeners();
        socket.emit("loginSuccess", currentUser.sId);
        getChatRooms();
      },
    );

    // Connect error
    socket.onConnectError(
      (data) {
        log("connection failed + $data");
        _isConnect = false;
        notifyListeners();
      },
    );

    // disconnect
    socket.onDisconnect(
      (data) {
        log("socketio Server disconnected");
        _isConnect = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    // _chatRoomsStream.close();
    super.dispose();
  }
}
