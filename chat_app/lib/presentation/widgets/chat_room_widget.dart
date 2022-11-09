import 'package:chat_app/data/models/auth_user.dart';
import 'package:chat_app/data/models/chat_room.dart';
import 'package:chat_app/data/models/user_presence.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final styleNotView = _isNotification(context)
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
      },
      visualDensity: const VisualDensity(vertical: 0.7),
      leading: StateAvatar(
        avatar: widget.user.urlImage ?? '',
        isStatus: widget.presence.presence!,
        radius: 60.r,
      ),
      title: Container(
        margin: EdgeInsets.only(
          top: 10.h,
          bottom: 8.h,
        ),
        child: Text(
          widget.user.name ?? "Unknow",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      subtitle: Container(
        margin: EdgeInsets.only(
          bottom: 4.h,
        ),
        child: Text(
          _isSender(context) + widget.chatRoom.lastMessage!.content,
          overflow: TextOverflow.ellipsis,
          style: styleNotView,
        ),
      ),
      trailing: widget.isCall != null
          ? Container(
              margin: EdgeInsets.fromLTRB(
                0,
                10.h,
                0,
                8.h,
              ),
              constraints: BoxConstraints(
                maxWidth: 40.h,
                maxHeight: 40.h,
              ),
              decoration: BoxDecoration(
                color:
                    widget.isDarkMode ? Colors.grey[800] : lightGreyLightMode,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Center(
                  child: Icon(
                CupertinoIcons.phone_solid,
                size: 20.r,
              )),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTimeRoom(widget.chatRoom.lastMessage!.time),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (_isNotification(context)) ...[
                  SizedBox(height: 14.h),
                  Container(
                    constraints: BoxConstraints(maxHeight: 20.h),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Center(
                        child: Text(
                          "${widget.chatRoom.state}",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.r,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  bool _isNotification(BuildContext context) {
    final currentUserID = context.watch<ChatBloc>().currentUser.sId;
    String senderID = widget.chatRoom.lastMessage!.idSender;
    int value = widget.chatRoom.state!;
    if (senderID != currentUserID && value > 0) {
      return true;
    }
    return false;
  }

  String _isSender(BuildContext context) {
    final currentUserID = context.watch<ChatBloc>().currentUser.sId;
    String senderID = widget.chatRoom.lastMessage!.idSender;

    if (currentUserID != senderID) return '';

    switch (widget.chatRoom.lastMessage!.type) {
      case 'text':
        return 'Bạn: ';
      default:
        return 'Bạn ';
    }
  }
}
