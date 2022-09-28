import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/pages/calls/calls_screen.dart';
import 'package:chat_app/presentation/pages/home/components/state_item_navigation.dart';
import 'package:chat_app/presentation/pages/setting/setting_screen.dart';
import 'package:chat_app/presentation/pages/stories/stories_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/presentation/pages/home/screens/home_screen.dart';
import 'package:chat_app/presentation/pages/home/components/app_bar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  List<Widget> pages = const <Widget>[
    HomeScreen(),
    CallsScreen(),
    StoriesScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarPage(
        currentPage,
        context,
        'assets/avatars/user1.jpg',
      ),
      body: SafeArea(child: pages[currentPage]),
      bottomNavigationBar: SizedBox(
        height: 72,
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
              icon: buildStateNavigationItem(
                icon: CupertinoIcons.chat_bubble_fill,
                valueState: '1',
              ),
              label: TITLES_PAGE[0],
            ),
            BottomNavigationBarItem(
              icon: buildStateNavigationItem(
                icon: CupertinoIcons.phone_solid,
              ),
              label: TITLES_PAGE[1],
            ),
            BottomNavigationBarItem(
              icon: buildStateNavigationItem(
                icon: CupertinoIcons.collections_solid,
              ),
              label: TITLES_PAGE[2],
            ),
            BottomNavigationBarItem(
              icon: buildStateNavigationItem(
                icon: Icons.settings,
              ),
              label: TITLES_PAGE[3],
            ),
          ],
        ),
      ),
    );
  }
}
