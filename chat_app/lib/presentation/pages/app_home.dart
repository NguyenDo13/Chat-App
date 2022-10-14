import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/services/auth_bloc/auth_bloc.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:chat_app/presentation/widgets/state_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<AuthBloc>().authUser;
    return Scaffold(
      appBar: _appBarPage(
        currentPage,
        context,
        authUser.user?.urlImage ?? '',
        authUser.user?.name ?? '',
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