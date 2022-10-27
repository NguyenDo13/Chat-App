import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/helper/loading/loading_screen.dart';
import 'package:chat_app/presentation/pages/add_friend/add_friend_screen.dart';
import 'package:chat_app/presentation/pages/app_manager/app_manager.dart';
import 'package:chat_app/presentation/pages/chat/chat_screen.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class AppPageController extends StatefulWidget {
  final AuthUser authUser;
  final List<dynamic> chatRooms;
  final List<dynamic>? friendRequests;
  const AppPageController({
    super.key,
    required this.authUser,
    required this.chatRooms,
    this.friendRequests,
  });

  @override
  State<AppPageController> createState() => _AppPageControllerState();
}

class _AppPageControllerState extends State<AppPageController> {
  late IO.Socket _socket;

  @override
  void initState() {
    _socket = IO.io(
      Environment(isServerDev: true).urlServer,
      <String, dynamic>{
        'transports': ['websocket'],
        'forceNew': true
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (_) => ChatBloc(
        socket: _socket,
        listDataRoom: widget.chatRooms,
        requests: widget.friendRequests,
        currentUser: widget.authUser.user!,
      ),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is HasSourceChatState) {
            return ChatScreen(
              friendID: state.friend.sId!,
              idRoom: state.idRoom,
            );
          }
          if (state is LookingForFriendState) {
            return const AddFriendScreen();
          }
          return AppManager(authUser: widget.authUser, socket: _socket);
        },
      ),
    );
  }
}
