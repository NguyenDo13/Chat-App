import 'dart:developer';

import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/home/search_screen.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/list_friends.dart';
import 'package:chat_app/presentation/pages/home/components/list_online_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Environment environment;
  late IO.Socket _socket;

  @override
  void initState() {
    environment = Environment(isServerDev: true);
    _socket = IO.io(
      environment.urlServer,
      IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
          // disable auto-connection
          .build(),
    );
    _connectSocket();
    super.initState();
  }

  _connectSocket() {
    _socket.onConnect(
      (data) => log("Connection established"),
    );
    _socket.onConnectError(
      (data) => log(
        "connection failed + $data",
      ),
    );
    _socket.onDisconnect(
      (data) => log(
        "socketio Server disconnected",
      ),
    );
    _socket.on(
      "message",
      (data) => log(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(_socket),
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is InitChatState) {
            context.read<ChatBloc>().add(ConnectToServer());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildSearchBarView(context, appState.darkMode),
                const ListOnlineUser(),
                ListFriends(
                  listUsers: LIST_USERS,
                  isChat: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBarView(context, theme) {
    return Container(
      height: Dimensions.height44,
      margin: EdgeInsets.fromLTRB(
        Dimensions.width14,
        Dimensions.height14,
        Dimensions.width14,
        0,
      ),
      decoration: BoxDecoration(
        color: theme ? darkGreyDarkMode : lightGreyLightMode,
        borderRadius: BorderRadius.circular(Dimensions.double36),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        child: Row(
          children: [
            SizedBox(width: Dimensions.width14),
            Icon(
              CupertinoIcons.search,
              color: theme ? Colors.white : darkGreyDarkMode,
              size: Dimensions.double40 / 2,
            ),
            SizedBox(width: Dimensions.width14),
            Text(
              'Tìm kiếm',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: theme ? Colors.white : darkGreyDarkMode,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
