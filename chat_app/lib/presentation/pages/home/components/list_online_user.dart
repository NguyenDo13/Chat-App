import 'package:chat_app/presentation/UIData/theme.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/material.dart';

class ListOnlineUser extends StatelessWidget {
  const ListOnlineUser({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listUsers = [
      'user1.jpg',
      'user2.jpg',
      'user3.jpg',
      'user4.jpeg',
      'user1.jpg',
      'user2.jpg',
      'user3.jpg',
      'user4.jpeg',
      'user1.jpg',
      'user2.jpg',
      'user3.jpg',
      'user4.jpeg',
      'user1.jpg',
      'user2.jpg',
      'user3.jpg',
      'user4.jpeg'
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      constraints: const BoxConstraints(maxHeight: 118),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 13,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            constraints: const BoxConstraints(maxWidth: 62),
            child: Column(
              children: [
                StateAvatar(
                  avatar: "assets/avatars/${listUsers[index]}",
                  isStatus: true,
                  radius: 60,
                ),
                const SizedBox(height: 4),
                Text(
                  'Bắt đầu cuộc gọi',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTheme.darkTextTheme.caption,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
