import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            JoinRoomEvent(
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
        margin: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: Dimensions.height8,
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
        child: Text(
          widget.chatRoom.lastMessage!, //* Content
          overflow: TextOverflow.ellipsis,
          style: styleNotView,
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
          : Column(
              children: [
                Text(
                  formatTime(widget.chatRoom.timeLastMessage!), //* time
                  style: styleNotView,
                ),
                SizedBox(
                  height: Dimensions.height14,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: Dimensions.height20),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Center(
                      child: Text(
                        '1',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}