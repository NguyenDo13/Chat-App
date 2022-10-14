// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/presentation/pages/chat/chat_screen.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';

class ListChatRoom extends StatefulWidget {
  final List<dynamic> listUsers;
  final bool isGroup;
  final bool? isCall;
  const ListChatRoom({
    Key? key,
    required this.listUsers,
    required this.isGroup,
    this.isCall,
  }) : super(key: key);

  @override
  State<ListChatRoom> createState() => _ListChatRoomState();
}

class _ListChatRoomState extends State<ListChatRoom> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemChat(context, index, appState);
        },
      ),
    );
  }

  Widget _itemChat(BuildContext context, int index, AppStateProvider appState) {
    // State text style which show notify that is not view
    final styleNotView = index < 2
        ? Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: lightBlue, fontWeight: FontWeight.w400)
        : Theme.of(context).textTheme.headlineSmall;

    return ListTile(
      onTap: () {
        if (!widget.isGroup) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          );
        }

        // TODO: change state item chat to viewed
      },
      visualDensity: const VisualDensity(vertical: 0.7),
      leading: StateAvatar(
        avatar:
            "assets/avatars/${widget.listUsers[index][0].avatar}", //* avatar
        isStatus: widget.listUsers[index][0].state, //* state
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
          widget.listUsers[index][0].username, //* Name
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.height4,
        ),
        child: Row(
          children: [
            SizedBox(
              width: Dimensions.width152,
              child: Text(
                widget.listUsers[index][1], //* Content
                overflow: TextOverflow.ellipsis,
                style: styleNotView,
              ),
            ),
            SizedBox(
              width: Dimensions.width8 / 2,
            ),
            Text(
              '|',
              style: styleNotView,
            ),
            SizedBox(
              width: Dimensions.width8 / 2,
            ),
            Text(
              widget.listUsers[index][2], //* time
              style: styleNotView,
            ),
          ],
        ),
      ),
      trailing: widget.isCall != null
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
                color:
                    appState.darkMode ? Colors.grey[800] : lightGreyLightMode,
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
  }
}
