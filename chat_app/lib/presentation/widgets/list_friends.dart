import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/home/screens/chat_screen.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListFriends extends StatelessWidget {
  final List<dynamic> listUsers;
  final bool isChat;
  const ListFriends({
    super.key,
    required this.listUsers,
    this.isChat = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              if (isChat) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              }
            },
            visualDensity: const VisualDensity(vertical: 0.7),
            leading: StateAvatar(
              avatar: "assets/avatars/${listUsers[index][0].avatar}", //* avatar
              isStatus: listUsers[index][0].state, //* state
              radius: Dimensions.double30 * 2,
            ),
            title: Container(
              margin: EdgeInsets.fromLTRB(
                0,
                Dimensions.height10,
                0,
                Dimensions.height8,
              ),
              child: Text(
                listUsers[index][0].username, //* Name
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(
                bottom: Dimensions.height4,
              ),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.width152,
                    child: Text(
                      listUsers[index][1], //* Content
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width8 / 2,
                  ),
                  Text(
                    '|',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    width: Dimensions.width8 / 2,
                  ),
                  Text(
                    listUsers[index][2], //* time
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            trailing: !isChat
                ? Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      Dimensions.height10,
                      0,
                      Dimensions.height8,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: Dimensions.height40,
                      maxHeight: Dimensions.height40,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(Dimensions.double40),
                    ),
                    child: Center(
                        child: Icon(
                      CupertinoIcons.phone_solid,
                      size: Dimensions.double40 / 2,
                    )),
                  )
                : null,
          );
        },
      ),
    );
  }
}
