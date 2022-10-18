// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:developer';

import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IO.Socket socket;
  final User currentUser;

  // ignore: unused_field
  bool _isConnect = false;
  List<dynamic> listDataRoom = [];

  //source chat
  List<dynamic> sourceChat = [];

  ChatBloc({
    required this.socket,
    required this.currentUser,
  }) : super(InitDataRoomState()) {
    checkConnectSocket();
    on<GetDataRoomsEvent>((event, emit) async {
      if (!_isConnect) return;
      if (currentUser.sId == null) return;
      await getRoomData();
    });

    on<OnRoomEvent>((event, emit) async {
      if (!_isConnect) return;
      await getSourceChat(event.roomID, event.friend);
    });
    on<ExitRoomEvent>((event, emit) {
      emit(HasDataRoomState(listDataRoom));
    });
  }

  Future getSourceChat(roomID, friend) async {
    socket.emit('onRoom', {"roomID": roomID});
    socket.on('onRoom', (data) async {
      if (data['sourceChat'] == null) return;
      sourceChat = await data['sourceChat'];
      if (sourceChat.isEmpty) return;
      emit(HasSourceChatState(sourceChat: sourceChat, currentUser: currentUser, friend: friend,));
    });
  }

  Future getRoomData() async {
    socket.emit("loginSuccess", currentUser.sId);
    socket.on('chatRooms', (data) async {
      listDataRoom = await data;
      emit(HasDataRoomState(listDataRoom));
    });
  }

  checkConnectSocket() {
    // Connected
    socket.onConnect(
      (data) {
        log("Connection established");
        _isConnect = true;
        add(GetDataRoomsEvent());
      },
    );

    // Connect error
    socket.onConnectError(
      (data) {
        log("connection failed + $data");
        _isConnect = false;
      },
    );

    // disconnect
    socket.onDisconnect(
      (data) {
        log("socketio Server disconnected");
        _isConnect = false;
      },
    );
  }
}
