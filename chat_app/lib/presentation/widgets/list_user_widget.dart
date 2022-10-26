import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListUserWidget extends StatelessWidget {
  final List<User> listUser;
  final Function() onTapItem;
  final Function()? addFriend;
  final bool isAddFriend;
  final bool? loadding;
  final bool? success;

  const ListUserWidget({
    super.key,
    required this.listUser,
    required this.onTapItem,
    required this.isAddFriend,
    this.addFriend,
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
          return Padding(
            padding: EdgeInsets.only(bottom: Dimensions.height10),
            child: ListTile(
              onTap: onTapItem,
              leading: Container(
                padding: EdgeInsets.only(right: Dimensions.width8),
                child: StateAvatar(
                  avatar: listUser[index].urlImage ?? '',
                  isStatus: false,
                  radius: Dimensions.double12 * 4,
                ),
              ),
              title: Text(
                listUser[index].name ?? 'UNKNOWN',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: isAddFriend ? _stateAcction() : null,
            ),
          );
        },
      ),
    );
  }

  Widget _stateAcction() {
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
        addFriend!();
      },
      child: const Icon(
        CupertinoIcons.person_add_solid,
      ),
    );
  }
}
