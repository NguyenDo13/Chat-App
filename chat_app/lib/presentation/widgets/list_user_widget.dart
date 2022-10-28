import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListUserWidget extends StatelessWidget {
  final List<dynamic> listUser;
  final bool isAddFriend;
  final bool? loadding;
  final bool? success;

  const ListUserWidget({
    super.key,
    required this.listUser,
    required this.isAddFriend,
    this.loadding,
    this.success,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listUser.length,
        itemBuilder: (context, index) {
          final friend = User.fromJson(listUser[index]);
          return Padding(
            padding: EdgeInsets.only(bottom: Dimensions.height10),
            child: ListTile(
              onTap: () {
                final userID = Provider.of<ChatBloc>(context, listen: false)
                    .currentUser
                    .sId;
                Provider.of<ChatBloc>(context, listen: false).add(
                  CheckHasRoomEvent(
                    userID: userID!,
                    friend: friend,
                    isOnl: false,
                  ),
                );
              },
              leading: Container(
                padding: EdgeInsets.only(right: Dimensions.width8),
                child: StateAvatar(
                  avatar: friend.urlImage ?? '',
                  isStatus: false,
                  radius: Dimensions.double12 * 4,
                ),
              ),
              title: Text(
                friend.name ?? 'UNKNOWN',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: isAddFriend ? _stateAcction(context, friend) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _stateAcction(BuildContext context, User friend) {
    if (loadding!) {
      return SizedBox(
        height: Dimensions.height12,
        width: Dimensions.height12,
        child: const CircularProgressIndicator(strokeWidth: 2.5),
      );
    }
    if (success!) {
      return const Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green,
      );
    }
    return InkWell(
      onTap: () {
        Provider.of<ChatBloc>(context, listen: false).add(
          FriendRequestEvent(
            friend: friend,
          ),
        );
      },
      child: const Icon(
        CupertinoIcons.person_add_solid,
      ),
    );
  }
}
