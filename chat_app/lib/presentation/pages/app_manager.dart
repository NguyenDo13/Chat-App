import 'package:chat_app/data/environment.dart';
import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/calls/calls_screen.dart';
import 'package:chat_app/presentation/pages/chat/chat_screen.dart';
import 'package:chat_app/presentation/pages/groups/group_chat.dart';
import 'package:chat_app/presentation/pages/home/home_screen.dart';
import 'package:chat_app/presentation/pages/setting/setting_screen.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:chat_app/presentation/widgets/state_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class AppManager extends StatefulWidget {
  final AuthUser authUser;
  const AppManager({super.key, required this.authUser});

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  int currentPage = 0;
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
    final List<Widget> pages = [
      HomeScreen(
        socket: _socket,
      ),
      const GroupChatScreen(),
      const CallsScreen(),
      SettingScreen(
        authUser: widget.authUser,
      )
    ];

    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        socket: _socket,
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
          return Scaffold(
            appBar: _appBarPage(
              currentPage,
              context,
              widget.authUser.user?.urlImage ?? '',
              widget.authUser.user?.name ?? '',
            ),
            body: SafeArea(child: pages[currentPage]),
            bottomNavigationBar: SizedBox(
              height: Dimensions.height72 + Dimensions.height4,
              child: BottomNavigationBar(
                currentIndex: currentPage,
                onTap: (currentIndex) {
                  setState(() {
                    currentPage = currentIndex;
                  });
                },
                selectedItemColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                items: [
                  BottomNavigationBarItem(
                    icon: const StateBottomNavigationBar(
                      icon: CupertinoIcons.chat_bubble_fill,
                      valueState: '1',
                    ),
                    label: TITLES_PAGE[0],
                  ),
                  BottomNavigationBarItem(
                    icon: const StateBottomNavigationBar(
                      icon: CupertinoIcons.group_solid,
                    ),
                    label: TITLES_PAGE[1],
                  ),
                  BottomNavigationBarItem(
                    icon: const StateBottomNavigationBar(
                      icon: CupertinoIcons.phone_solid,
                    ),
                    label: TITLES_PAGE[2],
                  ),
                  BottomNavigationBarItem(
                    icon: const StateBottomNavigationBar(
                      icon: Icons.settings,
                    ),
                    label: TITLES_PAGE[3],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBarPage(
    int currentPage,
    BuildContext context,
    String img,
    String name,
  ) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return AppBar(
      toolbarHeight: Dimensions.height72,
      title: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: Dimensions.width16),
            child: Center(
              child: StateAvatar(
                avatar: img,
                isStatus: false,
                text: takeLetters(name),
                radius: Dimensions.double40,
              ),
            ),
          ),
          Text(
            TITLES_PAGE[currentPage],
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.person_add_solid,
                color: appState.darkMode ? lightGreyDarkMode : darkGreyDarkMode,
                size: Dimensions.double30,
              ),
            ),
            Positioned(
              top: Dimensions.height10,
              right: -Dimensions.height2,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: Dimensions.height20 + Dimensions.height2),
                width: Dimensions.height20,
                height: Dimensions.height20,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.height2,
                  vertical: Dimensions.height2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.double40),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    '!',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: Dimensions.width14),
      ],
    );
  }
}
