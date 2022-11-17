import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/pages/home/components/add_new_friend.dart';
import 'package:chat_app/presentation/pages/home/components/no_have_friend.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'onl_friend.dart';

class ListOnlineUser extends StatelessWidget {
  final List<dynamic> listFriend;
  const ListOnlineUser({super.key, required this.listFriend});

  @override
  Widget build(BuildContext context) {
    return listFriend.isEmpty
        ? const NoHaveFriend()
        : Container(
            padding: EdgeInsets.fromLTRB(
              14.w,
              14.h,
              14.w,
              0,
            ),
            constraints: BoxConstraints(
              maxHeight: 120.h,
            ),
            // color: Colors.red,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: listFriend.length,
              itemBuilder: (BuildContext context, int index) {
                final friend = User.fromJson(listFriend[index]['friend']);
                final presence =
                    UserPresence.fromJson(listFriend[index]['presence']);
                AppStateProvider appStateProvider =
                    context.watch<AppStateProvider>();
                return Row(
                  children: [
                    if (index == 0) ...[
                      AddNewFriend(theme: appStateProvider.darkMode),
                    ],
                    OnlFriend(
                      friend: friend,
                      state: appStateProvider,
                      presence: presence,
                    ),
                  ],
                );
              },
            ),
          );
  }
}
