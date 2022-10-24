import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/presentation/pages/chat/components/message_item.dart';
import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/utils/functions.dart';
import 'package:chat_app/presentation/widgets/state_avatar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClusterMessages extends StatelessWidget {
  final bool theme;
  final bool isSender;
  final List<dynamic> messages;
  final String timeMessageItem;
  final bool stateLastMsg;
  final bool islastItem;
  const ClusterMessages({
    super.key,
    required this.theme,
    required this.isSender,
    required this.messages,
    required this.timeMessageItem,
    required this.stateLastMsg,
    required this.islastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: messages.map((item) {
                  final msg = Message.fromJson(item);
                  return MessageItem(
                    message: msg,
                    theme: theme,
                    isSender: isSender,
                  );
                }).toList(),
              ),
              SizedBox(
                height: Dimensions.height4,
              ),
              Row(
                children: [
                  Text(
                    formatTime(timeMessageItem),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: lightGreyDarkMode),
                  ),
                  if (!stateLastMsg && islastItem && isSender) ...[
                    SizedBox(
                      width: Dimensions.height4,
                    ),
                    Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      size: 16,
                      color: theme ? darkBlue : lightBlue,
                    ),
                  ],
                ],
              ),
              if (stateLastMsg && islastItem && isSender) ...[
                const StateAvatar(
                  avatar: 'assets/avatars/user1.jpg',
                  isStatus: false,
                  radius: 16,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
