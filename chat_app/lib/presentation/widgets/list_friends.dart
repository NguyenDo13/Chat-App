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
      constraints: const BoxConstraints(
        maxHeight: 1000,
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
              radius: 60,
            ),
            title: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
              child: Text(
                listUsers[index][0].username, //* Name
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            subtitle: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: Row(
                children: [
                  Text(
                    listUsers[index][1], //* Content
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '|',
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    listUsers[index][2], //* time
                    style: GoogleFonts.openSans(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing: !isChat
                ? Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                    constraints:
                        const BoxConstraints(maxWidth: 40, maxHeight: 40),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Center(
                        child: Icon(
                      CupertinoIcons.phone_solid,
                      size: 20,
                    )),
                  )
                : null,
          );
        },
      ),
    );
  }
}
