import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/widgets/list_friends.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Text("Gần đây",
                style: GoogleFonts.openSans(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                )),
          ),
          ListFriends(
            listUsers: LIST_USERS,
          ),
        ],
      ),
    );
  }
}
