import 'package:chat_app/presentation/helper/error/no_internet.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/widgets/new_list_chat_room.dart';
import 'package:chat_app/presentation/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/list_online_user.dart'; 
import 'package:socket_io_client/socket_io_client.dart' as IO;// ignore: library_prefixes

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
    AppStateProvider appState = context.watch<AppStateProvider>();
    final listFriend = context.watch<ChatBloc>().listFriend;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 14.h),
      physics: const BouncingScrollPhysics(),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state is JoinAppState) ...[
                if (!appState.hasConnect) ...[
                  const NoInternetText(),
                ],
                SearchBar(theme: appState.darkMode),
                ListOnlineUser(listOnlineFriend: listFriend ?? []),
                state.listRoom.isNotEmpty
                    ? NewListChatRoom(
                        listRoom: state.listRoom,
                        isGroup: false,
                      )
                    : const Center(child: Text("Không có gì!")),
              ],
            ],
          );
        },
      ),
    );
  }
}
