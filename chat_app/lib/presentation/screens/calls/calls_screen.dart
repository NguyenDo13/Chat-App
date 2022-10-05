import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/widgets/list_friends.dart';
import 'package:flutter/material.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(
              Dimensions.width14,
              Dimensions.height14,
              Dimensions.width14,
              0,
            ),
            child: Text(
              "Gần đây",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ListFriends(
            listUsers: LIST_USERS,
          ),
        ],
      ),
    );
  }
}
