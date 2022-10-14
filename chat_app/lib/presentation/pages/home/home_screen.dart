import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/repository/chat_repository.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/services/socketio_provider/chat_provider.dart';
import 'package:chat_app/presentation/pages/home/components/list_online_user.dart';
import 'package:chat_app/presentation/widgets/new_list_chat_room.dart';
import 'package:chat_app/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ChatRepository _chatRepository;
  late Environment _environment;
  late IO.Socket _socket;

  @override
  void initState() {
    _environment = Environment(isServerDev: true);
    _chatRepository = ChatRepository(
      environment: _environment,
    );
    _socket = IO.io(
      _environment.urlServer,
      IO.OptionBuilder().setTransports(['websocket']) // For Flutter or Dart VM
          // Disable auto-connection
          .build(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // init data of the user
    final authUser = Provider.of<AuthBloc>(context, listen: false).authUser;

    return ChangeNotifierProvider(
      create: (_) => ChatProvider(
        socket: _socket,
        currentUser: authUser.user!,
        chatRepository: _chatRepository,
      ),
      child: Consumer2<ChatProvider, AppStateProvider>(
        builder: (context, chat, appState, child) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(theme: appState.darkMode),
                const ListOnlineUser(),
                StreamBuilder<List<ChatRoom>>(
                    initialData: listChatRoomSample,
                    stream: chat.chatRooms,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.data != null) {
                        return NewListChatRoom(
                          listRoom: snapshot.data ?? [],
                          isGroup: false,
                          currentUserID: authUser.user!.sId!,
                        );
                      }
                      // if (snapshot.hasData) {
                      //   return NewListChatRoom(
                      //     listRoom: snapshot.data ?? [],
                      //     isGroup: false,
                      //     currentUserID: authUser.user!.sId!,
                      //   );
                      // }
                      return const Center(child: Text("error 500"));
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
