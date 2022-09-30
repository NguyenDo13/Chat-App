import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/home/screens/search_screen.dart';
import 'package:chat_app/presentation/widgets/list_friends.dart';
import 'package:chat_app/presentation/pages/home/components/list_online_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildSearchBarView(context),
          const ListOnlineUser(),
          ListFriends(listUsers: LIST_USERS, isChat: true),
        ],
      ),
    );
  }

  Widget _buildSearchBarView(context) {
    return Container(
      height: Dimensions.height44,
      margin: EdgeInsets.fromLTRB(
        Dimensions.width14,
        Dimensions.height14,
        Dimensions.width14,
        0,
      ),
      decoration: BoxDecoration(
        color: darkGreyDarkMode,
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
              color: Colors.white,
              size: Dimensions.double40 / 2,
            ),
            SizedBox(width: Dimensions.width14),
            Text(
              'Tìm kiếm',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
