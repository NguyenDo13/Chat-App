import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/constants.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarPage(
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

    AppBar _appBarPage(
    int currentPage,
    BuildContext context,
    String img,
  ) {
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
      actions: currentPage == 0
          ? [
              _actionButton(
                () {},
                Icons.camera_alt,
              ),
              _actionButton(
                () {},
                CupertinoIcons.pencil,
              ),
              SizedBox(width: Dimensions.width14),
            ]
          : [],
    );
  }

    IconButton _actionButton(Function() action, IconData icon) {
    return IconButton(
      onPressed: action,
      icon: Icon(
        icon,
        size: Dimensions.double30,
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
                top: -Dimensions.height2,
                right: -Dimensions.height2,
                child: Container(
                  constraints: BoxConstraints(maxWidth: Dimensions.height20),
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
                      valueState,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Colors.white,
                          ),
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