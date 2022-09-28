import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/pages/home/components/search_bar.dart';
import 'package:chat_app/presentation/widgets/list_friends.dart';
import 'package:chat_app/presentation/pages/home/components/list_online_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchBar(),
          const ListOnlineUser(),
          ListFriends(listUsers: LIST_USERS, isChat: true,)
        ],
      ),
    );
  }
}
