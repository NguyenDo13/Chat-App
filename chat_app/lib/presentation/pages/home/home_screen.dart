import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/pages/home/components/list_online_user.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/list_chat_room.dart';
import 'package:chat_app/presentation/widgets/new_list_chat_room.dart';
import 'package:chat_app/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class HomeScreen extends StatefulWidget {
  final IO.Socket socket;
  const HomeScreen({
    super.key,
    required this.socket,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // app states
    AppStateProvider appState = context.watch<AppStateProvider>();
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        print(state.toString());
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(theme: appState.darkMode),
              const ListOnlineUser(),
              state is HasDataRoomState
                  ? NewListChatRoom(
                      listRoom: state.listRoom,
                      isGroup: false,
                    )
                  : ListChatRoom(listUsers: LIST_USERS, isGroup: false),
            ],
          ),
        );
      },
    );
  }
}
