import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOnlineUser extends StatelessWidget {
  final List<User> listOnlineFriend;
  const ListOnlineUser({super.key, required this.listOnlineFriend});

  @override
  Widget build(BuildContext context) {
    AppStateProvider appStateProvider = context.watch<AppStateProvider>();
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.width14,
        Dimensions.height14,
        Dimensions.width14,
        0,
      ),
      constraints: BoxConstraints(
        maxHeight: Dimensions.height120 + Dimensions.height14,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listOnlineFriend.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {},
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: Dimensions.width12),
                constraints: BoxConstraints(maxWidth: Dimensions.width62),
                child: Column(
                  children: [
                    StateAvatar(
                      avatar: "",
                      isStatus: true,
                      radius: Dimensions.double30 * 2,
                    ),
                    SizedBox(height: Dimensions.height4),
                    Text(
                      'Nhóm mới',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: appStateProvider.darkMode
                          ? Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white)
                          : Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
