import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/pages/chat/chat_screen.dart';
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
        itemCount: 13,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatScreen(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.width12),
              constraints: BoxConstraints(maxWidth: Dimensions.width62),
              child: Column(
                children: [
                  StateAvatar(
                    avatar: "assets/avatars/${listUsers[index]}",
                    isStatus: true,
                    radius: Dimensions.double30 * 2,
                  ),
                  SizedBox(height: Dimensions.height4),
                  Text(
                    'Bắt đầu cuộc gọi',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
