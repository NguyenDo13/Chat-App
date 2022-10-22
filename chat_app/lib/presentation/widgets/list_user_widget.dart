import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';

class ListUserWidget extends StatelessWidget {
  final List<User> listUser;
  final Function() onTap;
  const ListUserWidget({super.key, required this.listUser, required this.onTap});

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
              onTap: onTap,
              leading: Container(
                padding: EdgeInsets.only(right: Dimensions.width8),
                child: StateAvatar(
                  avatar: listUser[index].urlImage ?? '',
                  isStatus: false,
                  radius: Dimensions.double12 * 4,
                  text: takeLetters(listUser[index].name ?? 'UNKNOWN'),
                ),
              ),
              title: Text(
                listUser[index].name ?? 'UNKNOWN',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          );
        },
      ),
    );
  }
}
