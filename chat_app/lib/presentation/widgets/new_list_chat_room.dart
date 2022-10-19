import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/app_state_provider/app_state_provider.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';

class NewListChatRoom extends StatefulWidget {
  final List<dynamic> listRoom;
  final bool isGroup;
  final bool? isCall;
  const NewListChatRoom({
    Key? key,
    required this.listRoom,
    required this.isGroup,
    this.isCall,
  }) : super(key: key);

  @override
  State<NewListChatRoom> createState() => _NewListChatRoomState();
}

class _NewListChatRoomState extends State<NewListChatRoom> {
  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = context.watch<AppStateProvider>();
    return Container(
      constraints: BoxConstraints(
        maxHeight: Dimensions.screenHeight,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.listRoom.length,
        itemBuilder: (BuildContext context, int index) {
          // parse here
          final roomData = widget.listRoom[index];
          final room = ChatRoom.fromJson(roomData['room']);
          final user = User.fromJson(roomData['user']);
          final presence = UserPresence.fromJson(roomData['presence']);
          return ChatRoomWidget(
            chatRoom: room,
            isDarkMode: appState.darkMode,
            isGroup: widget.isGroup,
            isCall: widget.isCall,
            user: user,
            presence: presence,
          );
        },
      ),
    );
  }
}

class ChatRoomWidget extends StatefulWidget {
  final ChatRoom chatRoom;
  final bool isDarkMode;
  final bool isGroup;
  final bool? isCall;
  final User user;
  final UserPresence presence;
  const ChatRoomWidget({
    super.key,
    required this.chatRoom,
    required this.isDarkMode,
    required this.isGroup,
    this.isCall,
    required this.user,
    required this.presence,
  });

  @override
  State<ChatRoomWidget> createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  @override
  Widget build(BuildContext context) {
    // State text style which show notify that is not view
    final styleNotView = widget.isDarkMode
        ? Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: lightBlue, fontWeight: FontWeight.w400)
        : Theme.of(context).textTheme.headlineSmall;

    return ListTile(
      onTap: () {
        if (!widget.isGroup) {
          Provider.of<ChatBloc>(context, listen: false).add(
            OnRoomEvent(
              roomID: widget.chatRoom.sId!,
              friend: widget.user,
              isOnl: widget.presence.presence!,
            ),
          );
        }

        // TODO: change state item chat to viewed
      },
      visualDensity: const VisualDensity(vertical: 0.7),
      leading: StateAvatar(
        avatar: widget.user.urlImage ?? '',
        text: takeLetters(widget.user.name ?? 'Unknow'),
        isStatus: widget.presence.presence!,
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
          widget.user.name ?? "Unknow",
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
                widget.chatRoom.lastMessage ?? 'Error', //* Content
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
              widget.chatRoom.timeLastMessage ?? 'Error', //* time
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
                    widget.isDarkMode ? Colors.grey[800] : lightGreyLightMode,
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
