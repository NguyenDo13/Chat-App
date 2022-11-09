import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/pages/calls/calls_screen.dart';
import 'package:chat_app/presentation/pages/groups/group_chat.dart';
import 'package:chat_app/presentation/pages/home/home_screen.dart';
import 'package:chat_app/presentation/pages/setting/setting_screen.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/widgets/app_bar_page_managar.dart';
import 'package:chat_app/presentation/widgets/state_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart'
    as IO; // ignore: library_prefixes

class AppManager extends StatefulWidget {
  final AuthUser authUser;
  final IO.Socket socket;
  const AppManager({super.key, required this.authUser, required this.socket});

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  DateTime timeBackPressed = DateTime.now();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        socket: widget.socket,
      ),
      const GroupChatScreen(),
      const CallsScreen(),
      SettingScreen(
        socket: widget.socket,
        authUser: widget.authUser,
      )
    ];
    List<dynamic>? valueRequest = context.watch<ChatBloc>().requests;
    bool theme = context.watch<AppStateProvider>().darkMode;
    String urlImage = context.watch<AppStateProvider>().urlImage;

    return WillPopScope(
      onWillPop: () => _exitApp(theme),
      child: Scaffold(
        appBar: appBarPageManagar(
          currentPage,
          context,
          urlImage,
          widget.authUser.user?.name ?? '',
          widget.socket,
          valueRequest != null ? valueRequest.length : 0,
        ),
        body: SafeArea(child: pages[currentPage]),
        bottomNavigationBar: SizedBox(
          height: 76.h,
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
      ),
    );
  }

  Future<bool> _exitApp(bool theme) async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);

    timeBackPressed = DateTime.now();
    if (isExitWarning) {
      Fluttertoast.showToast(
        msg: 'Press back again to exit',
        fontSize: 10.r,
        textColor: theme ? Colors.white : Colors.black,
        backgroundColor: theme ? darkGreyDarkMode : lightGreyLightMode,
      );
      return false;
    } else {
      Fluttertoast.cancel();
      return true;
    }
  }
}
