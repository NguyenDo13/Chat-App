import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/calls/calls_screen.dart';
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

  //* DS các trang cho navigation_bar
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
              icon: _buildStateNavigationItem(
                icon: CupertinoIcons.chat_bubble_fill,
                valueState: '1',
              ),
              label: TITLES_PAGE[0],
            ),
            BottomNavigationBarItem(
              icon: _buildStateNavigationItem(
                icon: CupertinoIcons.phone_solid,
              ),
              label: TITLES_PAGE[1],
            ),
            BottomNavigationBarItem(
              icon: _buildStateNavigationItem(
                icon: CupertinoIcons.collections_solid,
              ),
              label: TITLES_PAGE[2],
            ),
            BottomNavigationBarItem(
              icon: _buildStateNavigationItem(
                icon: Icons.settings,
              ),
              label: TITLES_PAGE[3],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateNavigationItem({
    required IconData icon,
    String? valueState,
  }) {
    return Stack(
      children: valueState != null
          ? [
              Icon(
                icon,
                size: Dimensions.height14 * 2,
              ),
              Positioned(
                top: 0,
                right: -Dimensions.height2,
                child: Container(
                  constraints: BoxConstraints(maxWidth: Dimensions.height19),
                  width: Dimensions.height19,
                  height: Dimensions.height19,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height2,
                    vertical: Dimensions.height2,
                  ),
                  decoration: BoxDecoration(
                    // color: darkGreyDarkMode,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1F000000),
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(Dimensions.double40),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      valueState,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ]
          : [
              Icon(
                icon,
                size: Dimensions.height14 * 2,
              ),
            ],
    );
  }
}
